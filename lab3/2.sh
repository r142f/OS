#!/bin/bash
touch ~/report
at -f 1.sh now + 2 minutes
(tail -f ~/report) |
  while true; do
    read LINE
    echo $LINE
  done
