#
# ~/.bash_profile
#
mysystem=`head -n1 /etc/issue |awk '{print $1}'`

[[ -f ~/.bashrc ]] && . ~/.bashrc

# {{{ Environment Variables
# set PATH so it includes user's private .bin if it exists
[ -d $HOME/.bin ] && export PATH=$PATH:$HOME/.bin

# add ARM environment
[ -d $HOME/.devenv/3.4.1/bin ] && export PATH=$PATH:$HOME/.devenv/3.4.1/bin

# add Ruby gems to PATH
[ -d $HOME/.gem/ruby/1.9.1/bin ] && export PATH=$PATH:$HOME/.gem/ruby/1.9.1/bin

# fcitx
export XIM=fcitx
export XIM_PROGRAM=/usr/bin/fcitx
export XIN_ARGS=""
if [ $mysystem == "Arch" ]; then
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"
else
    export GTK_IM_MODULE=xim
    export QT_IM_MODULE=xim
    export XMODIFIERS="@im=fcitx"
fi

unset mysystem

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
