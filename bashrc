# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[ -f /etc/bashrc ] && source /etc/bashrc
[ -f "$HOME/.shrc_local" ] && source "$HOME/.shrc_local"

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend

# set -o vi # Shell is vi mode

# Disable CTRL-S and CTRL-Q
[[ $- =~ i ]] && stty -ixoff -ixon

# Prompt {{{
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

normal="\[\e[0m\]"

# biblack="\[\e[1;90m\]"
bired="\[\e[1;91m\]"
bigreen="\[\e[1;92m\]"
# biyellow="\[\e[1;93m\]"
biblue="\[\e[1;94m\]"
# bipurple="\[\e[1;95m\]"
bicyan="\[\e[1;96m\]"
biwhite="\[\e[1;97m\]"
# biorange="\[\e[1;91m\]"

# white="\[\e[0;37m\]"

_virtualenv_prompt()
{
    if [[ -n "$VIRTUAL_ENV" ]]; then
        virtualenv=$(basename "$VIRTUAL_ENV")
        echo -e "($virtualenv$VIRTUALENV_THEME_PROMPT_SUFFIX) "
    fi
}

_osp_prompt()
{
  [[ -n "$OS_USERNAME" ]] && echo -e "$OS_USERNAME-$OS_REGION_NAME "
}

_update_ps1()
{
  local RET=$?
  if [[ $RET == 0 ]]; then
    ret_status="${bigreen}➜ "
  else
    ret_status="${bired}➜ "
  fi
  [[ -n $SSH_CLIENT  ]] && user_host="${biblue}\u@\h" || user_host=""

  # PS1="${biwhite}$(_virtualenv_prompt)${ret_status}${user_host} ${bicyan}\W ${bired}$(__git_ps1 "(%s)")${normal}\\$ ${white}"
  # PS1="${biwhite}$(_virtualenv_prompt)${ret_status}${user_host} ${bicyan}\W ${bired}$(__git_ps1 "(%s)")${normal}\\$ "
  PS1="${biwhite}$(_virtualenv_prompt)${ret_status}${user_host} ${bicyan}\W${bired}$(__git_ps1 "(%s)")${normal} "
}

[[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]] && PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# export PROMPT_COMMAND="echo -n [$(date +%k:%m:%S)]"

PS2='> '
PS3='> '
PS4='+ '
# }}}

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
if [[ -x $(command -v fbterm 2>/dev/null) ]]; then
  fbterm_tmp=0
  if [ $fbterm_tmp == 1 ]; then
    if [ "$TERM" = "linux" ]; then
      alias fbterm='LANG=zh_CN.UTF-8 fbterm'
      fbterm
    fi
  fi
  unset fbterm_tmp
fi
# }}}

export LESSCHARSET=utf-8
export CHEATCOLORS=true

# History {{{
# Don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth:erasedupes

HISTTIMEFORMAT='%F %T '

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# }}}

[ -f "$HOME/.bin/z.sh"   ] && source "$HOME/.bin/z.sh"
[ -f "$HOME/.shrc"       ] && source "$HOME/.shrc"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
