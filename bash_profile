#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

# {{{ Environment Variables
# set PATH so it includes user's private .bin if it exists
[ -d $HOME/.bin ] && export PATH=$PATH:$HOME/.bin

# add ARM environment
[ -d $HOME/.devenv/3.4.1/bin ] && export PATH=$PATH:$HOME/.devenv/3.4.1/bin

# add Ruby gems to PATH
[ -d $HOME/.gem/ruby/1.9.1/bin ] && export PATH=$PATH:$HOME/.gem/ruby/1.9.1/bin

# fcitx
#export XIM=fcitx
#export XIM_PROGRAM=fcitx
#export GTK_IM_MODULE=xim
#export QT_IM_MODULE=xim
#export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
echo "This is .profile" >> /loginmgs
