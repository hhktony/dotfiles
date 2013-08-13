#!/bin/sh

mysystem=`head -n1 /etc/issue |awk '{print $1}'`

if [ $mysystem == "Arch" ]; then
    if [ -d /etc/X11/xinit/xinitrc.d ]; then
        for f in /etc/X11/xinit/xinitrc.d*; do
            [ -x "$f" ] && . "$f"
        done
        unset f
    fi

    exec openbox-session
else
    [[ -f /etc/X11/xinit/xinitrc ]] && . /etc/X11/xinit/xinitrc
fi

unset mysystem
