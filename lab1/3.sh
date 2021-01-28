#!/bin/bash
echo -e "1) nano\n2) vi\n3) links\n4) exit menu"
read ans
case $ans in
1) /usr/bin/nano ;;
2) /usr/bin/vi ;;
3) /usr/bin/links ;;
4) exit ;;
esac
