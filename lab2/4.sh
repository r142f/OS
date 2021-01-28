#!/bin/bash
result=""
for pid in $(ps -eo pid); do
  ppid=$(grep -sE "^PPid:" /proc/$pid/status | awk '{print $2}')
  sum_exec_runtime=$(grep -s "sum_exec_runtime" /proc/$pid/sched | awk '{print $3}')
  nr_switches=$(grep -s "nr_switches" /proc/$pid/sched | awk '{print $3}')
  if [[ $pid = PID || -z "$ppid" || -z "$sum_exec_runtime" || -z "$nr_switches" ]]; then
    continue
  fi
  art=$(echo "$sum_exec_runtime / $nr_switches" | bc -l | awk '{printf "%.5f", $0}')
  result="$result$pid $ppid $art"$'\n'
done

echo $"$result" |
  sed '/^$/d' |
  sort -n -k 2 |
  awk '{printf "ProcessID=%s : Parent_ProcessID=%s : Average_Running_Time=%s\n", $1, $2, $3}' >iv.log
