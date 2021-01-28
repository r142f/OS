#!/bin/bash
mode="+"
res=1
(tail -f pipe_5) |
  while true; do
    read LINE
    case $LINE in
    "M")
      mode="*"
      ;;
    "A")
      mode="+"
      ;;
    "QUIT")
      echo "QUITTING"
      echo "FINAL RES: "$res
      exit 0
      ;;
    "ERROR")
      echo "GOT ERROR FROM GENERATOR"
      echo "LAST RES: "$res
      exit 1
      ;;
    *)
      if [[ $mode == "+" ]]; then
        res=$((res + LINE))
      else
        res=$((res * LINE))
      fi
      echo "CUR RES: "$res
      ;;
    esac
  done
