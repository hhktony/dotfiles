#!/usr/bin/env bash

#============================================================================================
#
#         FileName: rm.sh
#
#     Descriptions: 脚本不支持选项，直接执行即可
#
#          Version: 1.0
#          Created: 2012-11-30 11:52:23
#         Revision: (none)
#
#           Author: xutao(mark), butbueatiful@gmail.com
#          Company: wanwei-tech
#
#============================================================================================
#safe remove, mv the files to .Trash with unique name
#and log the acction

trash="$HOME/.Trash"
log="$HOME/.Trash/trash.log"
bdate=`date "+%Y-%m-%d-%H:%M:%S"` #current time

if [[ ! -d "${trash}" ]]; then
    mkdir ${trash}
    touch ${log}
fi

if [[ ! -f "${log}" ]]; then
    touch ${log}
fi

while [ -e "$1" ]; do
#remove the possible ending /
file=`echo $1 |sed 's#\/$##' `

pure_filename=`echo $file  |awk -F / '{print $NF}' |sed -e "s#^\.##" `

if [ `echo $pure_filename | grep "\." ` ]; then
    new_file=` echo $pure_filename |sed -e "s/\([^.]*$\)/$bdate.\1/" `
else
    new_file="$pure_filename.$bdate"
fi

trash_file="$trash/$new_file"
mv "$file" "$trash_file"

if [ -w $log ]; then
    echo -e "[$bdate]\t$file\t=>\t[$trash_file]" |tee -a $log
else
    echo -e "[$bdate]\t$file\t=>\t[$trash_file]"
fi

shift   #increment the loop
done
