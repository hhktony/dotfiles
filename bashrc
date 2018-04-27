# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[ -f /etc/bashrc ] && source /etc/bashrc

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend

# set -o vi # Shell is vi mode

# Bash completion
[ -r /etc/bash_completion ] && . /etc/bash_completion

# Disable CTRL-S and CTRL-Q
[[ $- =~ i ]] && stty -ixoff -ixon

# Default prompt
PS1='[\u@\h \W]\$ '
# PS1='\[\033[01;32m\]\u\[\033[01;34m\] \W \$\[\033[00m\] '

__git_ps1() { :;}
[ -e /usr/share/git-core/contrib/completion/git-prompt.sh ] && source /usr/share/git-core/contrib/completion/git-prompt.sh
# GIT_PS1_SHOWCOLORHINTS=true
# GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
PS1='\[\e[1;92m\]\u\[\e[m\] \[\e[1;94m\]\W\[\e[m\] \[\e[1;91m\]$(__git_ps1 "(%s)")\[\e[m\]\[\e[1;92m\]\$\[\e[m\] \[\e[0;37m\]'

PS2='> '
PS3='> '
PS4='+ '

# colorful man page {{{
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# }}}

# fbterm {{{
fbterm_tmp=0
if [ $fbterm_tmp == 1 ]; then
  if [ "$TERM" = "linux" ]; then
    alias fbterm='LANG=zh_CN.UTF-8 fbterm'
    fbterm
  fi
fi
unset fbterm_tmp
# }}}

export LESSCHARSET=utf-8
# export LESS="-R"

[ -f $HOME/.shrc         ] && source "$HOME/.shrc"
[ -f $HOME/.bash_prompt  ] && source "$HOME/.bash_prompt"
[ -f $HOME/.bin/z.sh     ] && source "$HOME/.bin/z.sh"
[ -f $HOME/.shrc_local   ] && source "$HOME/.shrc_local"
export CHEATCOLORS=true
# export PROMPT_COMMAND="echo -n [$(date +%k:%m:%S)]"

# vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
