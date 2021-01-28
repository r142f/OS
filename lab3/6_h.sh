#!/bin/bash
echo $$ >.pid_6
res=1
USR2() {
  res=$((res * 2))
}
USR1() {
  res=$((res + 2))
}
SIGTERM() {
  echo "GOT 'SIGTERM' FROM GENERATOR"
  echo "RES: "$res
  rm .pid_6
  exit 0
}

trap 'USR1' USR1
trap 'USR2' USR2
trap 'SIGTERM' SIGTERM

while true; do
  sleep 1
done
