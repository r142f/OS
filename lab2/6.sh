#!/bin/bash
grep -E "^VmSize:" /proc/*/status |
  awk -F ":[[:space:]]+" '{print $1, $2}' |
  sort -n -k 2 |
  tail -n 1
