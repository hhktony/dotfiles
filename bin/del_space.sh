#!/usr/bin/env bash

if [ $# -ne 1 ]
then
	echo "Usage $0 <dirpath>"
fi

ls $1 | while read filename;
do
	echo "$filename" |grep -q " "

	if [ $? -eq 0 ]
	then
		old_file_name=$1/${filename}
		new_file_name=`echo ${old_file_name} | tr -d ' '`
		mv "${old_file_name}" "${new_file_name}"
		echo $_
	fi
done
