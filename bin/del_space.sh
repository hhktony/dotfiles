#!/usr/bin/env bash

if [ $# -ne 1 ]; then
  echo "Usage $0 <dirpath>"
  exit
fi

ls $1 | while read filename; do
  echo "$filename" | grep -q " "

  if [ $? -eq 0 ]; then
    old_file=$1/${filename}
    new_file_name=`echo ${old_file} | tr -d ' '`
    mv "${old_file}" "${new_file}"
    echo $_
  fi
done
