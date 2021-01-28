#!/bin/bash
#a
if [[ $# -ne 1 ]]; then
  echo "Wrong amount of arguments. Usage: bash untrash.sh <filename>"
  exit 1
fi

#b
filename=$1
trash=~/.trash
NL=$'\n'
while true; do
  for record in $(grep -h "/$filename " ~/.trash.log | awk '{printf "%s:%s\n", $1, $2}'); do
    full_filename=$(echo $record | awk -F: '{print $1}')
    path_to_file=${full_filename%$filename}
    link_name=$(echo $record | awk -F: '{print $2}')
    while true; do
      echo "Do you want to restore '$full_filename' (link name: $link_name)?${NL}0. n - no,${NL}1. y - yes"
      read answer

      #c
      if [[ ! -z $answer && $answer =~ ^[Yy1] ]]; then
        if [[ ! -d $path_to_file ]]; then
          echo "Path '$path_to_file' doesn't exist. File will be restored in the home directory instead."
          path_to_file=$HOME
        fi

        ln $trash/$link_name $path_to_file/$filename &>/dev/null ||
          {
            echo "'$filename' already exists in '$path_to_file'. Type a new name for the file to restore: "
            read filename
            while [[ -f $filename ]]; do
              echo "'$filename' already exists in '$path_to_file'. Type a new name for the file to restore: "
              read filename
            done
            ln $trash/$link_name $path_to_file/$filename
          }

        if [[ -f $path_to_file/$filename ]]; then
          echo "File restored at '$path_to_file$filename'."
          rm $trash/$link_name
          grep -hv $full_filename" "$link_name ~/.trash.log >.trash_cp.log
          mv .trash_cp.log ~/.trash.log
        fi
        exit 0

      elif [[ ! -z $answer && $answer =~ ^[Nn0] ]]; then
        break
      else
        echo "Couldn't parse answer!"
        continue
      fi
    done
  done
  echo "Didn't find needed '$filename' in '$trash'. Type a new name for the file to restore: "
  read filename
done
