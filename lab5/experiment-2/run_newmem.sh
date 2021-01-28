#!/bin/bash
K=30
N=$1
for ((i = 0; i < $K; i++)); do
  echo $i" process has started"
  (bash newmem.bash $N) &
done
