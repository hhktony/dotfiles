# {{{ Environment Variables
# set PATH so it includes user's private .bin if it exists
[[ -f $HOME/.bin/z.sh ]] && source $HOME/.bin/z.sh
[[ -f $HOME/.golangrc ]] && source $HOME/.golangrc
[[ -d $HOME/.bin ]]      && export PATH=$PATH:$HOME/.bin

# fcitx
# export XIM=fcitx
# export XIM_PROGRAM=fcitx
# export GTK_IM_MODULE=xim
# export QT_IM_MODULE=xim
# export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
