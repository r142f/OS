#!/bin/bash
NL=$'\n'
result=""
line=""
last_ppid="0"
art_sum=0
count=0
while read line; do
  ppid=$(echo $line | grep -Eo "Parent_ProcessID=[0-9]+" | awk -F "=" '{print $2}')
  art=$(echo $line | grep -Eo "Average_Running_Time=[0-9.]+" | awk -F "=" '{print $2}')
  if [[ $last_ppid -eq $ppid ]]; then
    result="$result$line${NL}"
    art_sum=$(echo "$art_sum + $art" | bc -l | awk '{printf "%.5f", $0}')
    let count=count\+1
  else
    avg_art=$(echo "$art_sum / $count" | bc -l | awk '{printf "%.5f", $0}')
    result="${result}Average_Running_Children_of_ParenID=$last_ppid is $avg_art${NL}$line${NL}"
    last_ppid="$ppid"
    art_sum=$art
    count=1
  fi
done <iv.log
avg_art=$(echo "$art_sum / $count" | bc -l | awk '{printf "%.5f", $0}')
result="${result}Average_Running_Children_of_ParenID=$last_ppid is $avg_art"
echo $"$result" >v.log
