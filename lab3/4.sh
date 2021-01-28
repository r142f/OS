#!/bin/bash
inf_loop="while true; do n=$((2 * 3)); done"
(bash <<<$inf_loop) &
(bash <<<$inf_loop) &
(bash <<<$inf_loop) &

echo "scipt pid $$"
echo $(pgrep -P $$)

pid1=$(pgrep -P $$ | head -n 1)
pri=0
(while true; do
  cpu=$(top -b -p $pid1 -n 1 | tail -n 1 | awk '{print $9}')
  if [[ $(echo "$cpu > 10.0" | bc) -eq 1 ]]; then
    pri=$((pri + 1))
    renice -n $pri -p $pid1 &>/dev/null
  fi
  sleep 5
done) &
