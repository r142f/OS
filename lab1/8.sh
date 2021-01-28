#!/bin/bash
cat /etc/passwd | awk -F ':' '{printf "%s:%s\n", $1, $3}' | sort -n -t ':' -k 2
