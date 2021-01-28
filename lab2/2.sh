#!bin/bash
ps -e -o cmd,pid | grep "^/sbin/" | grep -Eo '[0-9]+$'
