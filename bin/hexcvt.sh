#!/usr/bin/env bash
# bc: 十六进制必须大写

if [ $# != 1 -a $# != 3 ]; then
    printf "\E[01;33m Usage: $0 num input output\E[0m\n\n"
    exit 1
fi

if [ $# = 1 ]; then
    output=16
    input=10
fi

if [ $# = 3 ]; then
    output=$3
    input=$2
fi

num=`tr '[a-z]' '[A-Z]' <<< "$1"`
echo "obase=$output; ibase=$input; $num" | bc
