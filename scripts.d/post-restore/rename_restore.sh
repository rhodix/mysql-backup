#!/bin/bash
# Rename restore file.
if [[ -n "$DB_DUMP_DEBUG" ]]; then
  set -x
fi

if [ -e ${DB_RESTORE_TARGET} ];
then
  now=$(date +"%Y-%m-%d-%H_%M")
  new_name=${DB_RESTORE_TARGET}-${now}
  old_name=$(basename ${DB_RESTORE_TARGET})
  echo "Renaming backup file from ${old_name} to ${new_name}"
  mv ${DB_RESTORE_TARGET} ${new_name}
else
  echo "ERROR: Backup file ${DB_RESTORE_TARGET} does not exist!"
fi
