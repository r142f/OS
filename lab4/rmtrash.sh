#!/bin/bash
#a
if [[ $# -ne 1 ]]; then
  echo "Wrong amount of arguments. Usage: bash rmtrash.sh <filename>"
  exit 1
fi
if [[ ! -f "$PWD/$1" ]]; then
  echo "File '$1' doesn't exist in current directory"
  exit 1
fi

#b
trash=~/.trash
[ -d $trash ] ||
  {
    mkdir $trash && echo "Created trash"
  }

#c
link_name=$(date '+%s')
ln $PWD/$1 $trash/$link_name && rm $1 ||
  {
    echo "Couldn't move "$1" to trash"
    exit 1
  }

#d
echo "Moved '$1' to trash!"
echo "$PWD/$1 $link_name" >>~/.trash.log
