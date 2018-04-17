#!/usr/bin/env bash

#=====================================================
#
#         FileName: rm.sh
#
#     Descriptions: 脚本不支持选项，直接执行即可
#
#          Version: 1.0
#          Created: 2012-11-30 11:52:23
#         Revision: (none)
#
#           Author: xutao(Tony Xu), hhktony@gmail.com
#          Company: myself
#
#=====================================================
#safe remove, mv the files to .Trash with unique name
#and log the acction

trash="$HOME/.Trash"
log="$HOME/.Trash.log"
bdate=`date "+%Y-%m-%d-%H:%M:%S"` #current time

[[ ! -d ${trash} ]] && mkdir ${trash}

[[ ! -f ${log} ]]   &&  touch ${log}

while [ -e "$1" ]
do
    # Remove the possible ending /
    file=`echo $1 |sed 's#\/$##' `

    pure_filename=`echo $file  |awk -F / '{print $NF}' |sed -e "s#^\.##" `

    [ `echo $pure_filename | grep "\." ` ] \
    && new_file=` echo $pure_filename | sed -e "s/\([^.]*$\)/$bdate.\1/" ` \
    || new_file="$pure_filename.$bdate"

    trash_file="$trash/$new_file"
    mv "$file" "$trash_file"

    [ -w $log ] && \
    echo -e "[$bdate]\t$file\t=>\t[$trash_file]" | tee -a $log \
    || echo -e "[$bdate]\t$file\t=>\t[$trash_file]"

    shift   #increment the loop
done
