#!/usr/bin/env bash
#  Filename: vim-starttime.sh
#      Desc: TODO (some description)
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself
log_file=/tmp/vim_startup.log
[ -f $log_file ] && rm $log_file

nvim --startuptime $log_file && awk -F'[ /]' '/\.vim\/plugged/ {print $3,$12}' $log_file | \
awk '{plug[$2]++; time[$2]+=$1} END {for (i in plug) {printf "%30s %20.3f ms\n", i, time[i] | "sort -k2nr"}}'
