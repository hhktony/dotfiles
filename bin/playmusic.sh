#!/usr/bin/env bash
#  Filename: playmusic.sh
#   Created: 2012-10-09 09:12:51
#      Desc:
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself

#program="mplayer -shuffle -playlist"
program="mpg123 --shuffle --list"
music_dir="$HOME/Music"
play_list="$HOME/.music.lst"

$HOME/.bin/del_space.sh $music_dir
ls $music_dir/*.mp3 > $play_list

cur_status=`ps ax |grep "$program $play_list" | grep -v 'grep' | awk '{print $1}' `
[ ! -z $cur_status ] &&  exec kill -9 $curstatus || exec $program $play_list
