#!/bin/bash
backup_d=/home/user
source_d=/home/user/source

latest_backup_date=$(ls $backup_d |
  grep -E "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" |
  awk -F- '{printf "%s-%s-%s\n", $2, $3, $4}' |
  sort -n -t "-" |
  tail -n 1)
latest_backup_time=$(date -d $latest_backup_date '+%s' 2>/dev/null)

current_backup_time=$(date +"%s")
current_backup_date=$(date -d @$current_backup_time '+%F')

new_files=""
changed_files=""
NL=$'\n'

#b
if [[ -z $latest_backup_date || $((current_backup_time - latest_backup_time)) -ge 604800 ]]; then
  current_backup_name="Backup-$current_backup_date"
  current_backup_path=$backup_d/$current_backup_name
  mkdir $current_backup_path
  cp -r $source_d/* $current_backup_path
  new_files=$(find $current_backup_path -type f)

#c
else
  current_backup_name="Backup-$latest_backup_date"
  current_backup_path=$backup_d/$current_backup_name
  for file in $(find $source_d/* -type f); do
    file_name=${file#"$source_d/"}

    if [[ -f $current_backup_path/$file_name ]]; then
      file_size=$(stat -c %s $file)
      file_size_backup=$(stat -c %s $current_backup_path/$file_name)

      if [[ $file_size -ne $file_size_backup ]]; then
        new_file_name_backup=$file_name"."$current_backup_date
        mv $current_backup_path/$file_name $current_backup_path/$new_file_name_backup
        cp $file $current_backup_path/$file_name
        changed_files="$changed_files${NL}$file_name:$new_file_name_backup"
      fi

    else
      new_files="$new_files${NL}$file_name"
      drnm=$(dirname $current_backup_path/$file_name)
      mkdir -p $drnm && cp $file $current_backup_path/$file_name
    fi
  done
fi

echo "updated_backup $current_backup_path $current_backup_date" >>$backup_d/backup_report
for file in $new_files; do
  echo "--new_file $file" >>$backup_d/backup_report
done
for record in $changed_files; do
  record=$(echo $record | awk -F: '{print $1, $2}')
  echo "--changed_file $record" >>$backup_d/backup_report
done
