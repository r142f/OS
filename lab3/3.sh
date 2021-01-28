#!/bin/bash
crontab -l >mycron
echo "0-59/5 * * * "$(date '+%a')" sh /home/user/OS_CLONE/OS/lab3/1.sh" >>mycron
crontab mycron
rm mycron
