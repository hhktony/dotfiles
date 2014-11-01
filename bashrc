# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Read /etc/bashrc, if there are
[ -f /etc/bashrc ] && source /etc/bashrc

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
shopt -s checkwinsize

# History {{{
# Don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth:erasedupes

HISTTIMEFORMAT='%F %T '

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# }}}

# set -o vi 	# Shell is vi mode

#  bash-completion {{{
bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}

if [ -n "$PS1" ]; then
  if [ $bmajor -eq 2 -a $bminor '>' 04 ] || [ $bmajor -gt 2 ]; then
    if [ -r /etc/bash_completion ]; then
      # Source completion code.
      . /etc/bash_completion
    fi
  fi
fi
unset bash bminor bmajor
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
fbterm_tmp=0
if [ $fbterm_tmp == 1 ]; then
    if [ "$TERM" = "linux" ]; then
        alias fbterm='LANG=zh_CN.UTF-8 fbterm'
        fbterm
    fi
fi
unset fbterm_tmp
# }}}

export EDITOR="vim"
export SVN_EDITOR="$EDITOR --nofork"
export CVS_RSH=ssh
export WWW_HOME=http://butbueatiful.github.io
export LESSCHARSET=utf-8
#export LESS="-R"
#export CDPATH=.:$HOME/Yunio/srcs

[[ -f $HOME/.bash_aliases   ]] && source $HOME/.bash_aliases
[[ -f $HOME/.bash_prompt    ]] && source $HOME/.bash_prompt
[[ -f $HOME/.bin/z.sh       ]] && source $HOME/.bin/z.sh
[[ -f $HOME/.bashrc_local   ]] && source $HOME/.bashrc_local

# {{{ Environment Variables
# set PATH so it includes user's private .bin if it exists
[[ -d $HOME/.bin ]]                 && export PATH=$PATH:$HOME/.bin
# add ARM environment
[[ -d $HOME/.devenv/3.4.1/bin ]]    && export PATH=$PATH:$HOME/.devenv/3.4.1/bin
# add Ruby gems to PATH
[[ -d $HOME/.gem/ruby/1.9.1/bin ]]  && export PATH=$PATH:$HOME/.gem/ruby/1.9.1/bin
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]]   && source $HOME/.rvm/scripts/rvm
# set Android environment
[[ -f $HOME/.androidrc ]]           && source $HOME/.androidrc
# set Oracle environment
[[ -f $HOME/.oraclerc ]]            && source $HOME/.oraclerc
# }}}

# export PROMPT_COMMAND="echo -n [$(date +%k:%m:%S)]"

# vim: syntax=sh set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
