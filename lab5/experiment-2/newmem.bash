#!/bin/bash
N=$1
a=()
while [[ ${#a[*]} -lt $N ]]; do
  a+=(0 0 0 0 0 0 0 0 0 0)
done
