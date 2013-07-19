# ~/.bashrc - startup file for Bash interactive shell

# Check for an interactive session
[ -z "$PS1" ] && return

# Read /etc/bashrc, if there are
[ -f /etc/bashrc ] && source /etc/bashrc

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
shopt -s checkwinsize

# {{{ History
HISTCONTROL=ignoreboth:erasedupes
HISTTIMEFORMAT='%F %T '
# append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
# }}} History End

#set -o vi 	# Shell is vi mode

# {{{ fbterm
fbterm_tmp=0
if [ $fbterm_tmp == 1 ]; then
    if [ "$TERM" = "linux" ]; then
        alias fbterm='LANG=zh_CN.UTF-8 fbterm'
        fbterm
    fi
fi
unset fbterm_tmp
# }}} fbterm end

# {{{ bash-completion
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
### }}} bash_completion end

# {{{ colorful man page
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# }}} colorful man page end

# {{{ Environment Variables
# set PATH so it includes user's private .bin if it exists
if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi

# add ARM environment
if [ -d "$HOME/.devenv/3.4.1/bin" ] ; then
    PATH="$HOME/.devenv/3.4.1/bin:$PATH"
fi

# add Ruby gems to PATH
if [ -d "$HOME/.gem/ruby/1.9.1/bin" ] ; then
    PATH="$HOME/.gem/ruby/1.9.1/bin:$PATH"
fi

# set Android environment
if [ -f "$HOME/.androidrc" ]; then
    . "$HOME/.androidrc"
fi

# set Oracle environment
if [ -f "$HOME/.oraclerc" ]; then
    . "$HOME/.oraclerc"
fi

export EDITOR="vim"
export SVN_EDITOR="$EDITOR --nofork"
export CVS_RSH=ssh
export WWW_HOME=http://www.archlinux.org
#export LESS="-R"
#export CDPATH=.:$HOME/Yunio/srcs

# fcitx
#export XIM=fcitx
#export XIM_PROGRAM=fcitx
#export GTK_IM_MODULE=xim
#export QT_IM_MODULE=xim
#export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
# }}} Environment Variables End

[ -f $HOME/.bashrc_local ] && source $HOME/.bashrc_local
[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases
[ -f $HOME/.bash_prompt ] && source $HOME/.bash_prompt
[ -f $HOME/.bin/z.sh ] && source $HOME/.bin/z.sh

#export PROMPT_COMMAND="echo -n [$(date +%k:%m:%S)]"
