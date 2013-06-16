#!/bin/sh

export mysystem=`head -n1 /etc/issue |awk '{print $1}'`

[[ $mysystem == "Arch" ]] && mysystem="ArchLinux"

if [ $mysystem == "ArchLinux" ]; then
    if [ -d /etc/X11/xinit/xinitrc.d ]; then
        for f in /etc/X11/xinit/xinitrc.d*; do
            [ -x "$f" ] && . "$f"
        done
        unset f
    fi

exec openbox-session
fi
