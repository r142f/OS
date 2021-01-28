#!/bin/bash
echo "Started logging (PID $$)"
while true; do
  echo "----------------------" >>top.log
  top -bn 1 -c | head -n 12 >>top.log
  sleep 1
done
