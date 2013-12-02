#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx(Slim (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

export XIM=fcitx
export XIM_PROGRAM=/usr/bin/fcitx
export XIN_ARGS=""
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

xrdb -merge ~/.Xresources

exec openbox-session
