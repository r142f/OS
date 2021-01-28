#!/bin/bash
read temp
ans=""
while [ $temp != q ]; do
  ans="$ans$temp"
  read temp
done
echo $ans
