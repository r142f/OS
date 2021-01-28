#!/bin/bash
NL=$'\n'
from_state=""
for pid in $(ps -Ao pid); do
  read_bytes=$(grep -sE "^read_bytes:" /proc/$pid/io | awk -F ":[[:space:]]+" '{print $2}')
  if [[ $pid = PID || -z $read_bytes ]]; then
    continue
  fi
  from_state="$from_state$pid $read_bytes$NL"
done

from_state=$(echo $"$from_state" | sed '/^$/d')
sleep 60
diff_state=""

for pid in $(ps -Ao pid); do
  to_read_bytes=$(grep -sE "^read_bytes:" /proc/$pid/io | awk -F ":[[:space:]]+" '{print $2}')
  from_read_bytes=$(echo $"$from_state" | grep -E "^$pid [0-9]" | awk '{print $2}')
  if [[ $pid = PID || -z $to_read_bytes || -z $from_read_bytes ]]; then
    continue
  fi
  diff_rb=$(echo "$to_read_bytes - $from_read_bytes" | bc -l)
  cmd=$(ps -p $pid -o cmd | tail -n 1)
  diff_state="$diff_state$pid:$cmd:$diff_rb$NL"
done

diff_state=$(echo $"$diff_state" | sed '/^$/d')
echo $"$diff_state" | sort -t ":" -n -k 3 | tail -n 3
