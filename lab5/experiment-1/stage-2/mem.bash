#!/bin/bash
report=report.log
rm -f $report
i=0
a=()
while true; do
  a+=(0 0 0 0 0 0 0 0 0 0)
  i=$((i + 1))
  if [[ i -gt 0 && $((i % 100000)) == 0 ]]; then
    echo ${#a[*]} >>$report
  fi
done
