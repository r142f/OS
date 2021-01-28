#!/bin/bash
backup_d=/home/user
latest_backup_date=$(ls $backup_d |
  grep -E "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" |
  awk -F- '{printf "%s-%s-%s\n", $2, $3, $4}' |
  sort -n -t "-" |
  tail -n 1)
latest_backup_name="Backup-$latest_backup_date"
latest_backup_path=$backup_d/$latest_backup_name

restore_d=/home/user/restore
[ -d $restore_d ] || mkdir $restore_d

for file in $(find $latest_backup_path/* -type f); do
  file_name=${file#"$latest_backup_path"}
  if [[ ! $file =~ \.[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    drnm=$(dirname $restore_d/$file_name)
    mkdir -p $drnm && cp $file $restore_d/$file_name
  fi
done
