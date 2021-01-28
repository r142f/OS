#!bin/bash
processes=$(ps -e -o pid,cmd,user | grep -E 'user$')
echo "$processes" | wc -l >1.log
echo "$processes" | awk '{printf "%s:%s\n", $1, $2}' >>1.log
