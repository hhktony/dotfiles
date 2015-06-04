#!/usr/bin/env bash
#********************************************************************************************
#           FileName: playmusic
#            Version: 0.0.1
#        LastChange: 2012-10-09 09:12:51
#              History:
#
#            Author: xutao
#              Email: hhktony@gmail.com
#            HomePage: hhktony.github.com
#              Company: akaedu.org
#          Copyright: Copyright (c) 2012, xutao
#
#        Descriptions: auto play(or close) music in the background
#        		Usage: Bind a shortcut key to execute the script(openbox is convenient)
#********************************************************************************************
#program="mplayer -shuffle -playlist"
program="mpg123 --shuffle --list"
music_dir="$HOME/Music"
play_list="$HOME/.music.lst"

$HOME/.bin/del_space.sh $music_dir
ls $music_dir/*.mp3 > $play_list

curstatus=`ps ax |grep "$program $play_list" | grep -v 'grep' | awk '{print $1}' `

if [ ! -z $curstatus ] ; then
	exec kill -9 $curstatus
else
	exec $program $play_list
fi
