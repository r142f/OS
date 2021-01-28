#!/bin/bash
mkfifo pipe_5

while true; do
  read LINE
  case $LINE in
  \*)
    echo "M" >pipe_5
    ;;
  +)
    echo "A" >pipe_5
    ;;
  QUIT)
    echo "QUIT" >pipe_5
    exit 0
    ;;
  *)
    sign="+"
    if [[ ${LINE:0:1} == "+" || ${LINE:0:1} == "-" ]]; then
      sign=${LINE:0:1}
      LINE=${LINE:1}
    fi
    if [[ $LINE =~ ^[0-9]+$ ]]; then
      echo $sign$LINE >pipe_5
    else
      echo "ERROR" >pipe_5
      echo "ERROR: NOT AN INTEGER"
      exit 1
    fi
    ;;
  esac
done
