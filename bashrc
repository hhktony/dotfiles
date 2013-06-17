# ~/.bashrc - startup file for Bash interactive shell

if [ -f /etc/bashrc ]; then
    . /etc/bashrc   # --> Read /etc/bashrc, if there are.
fi

# default prompt
PS1='[\u@\h \W]\$ '

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

# {{{ Colors
case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
esac

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.

# Dynamically modified variables. Do not change them!
use_color=false
# sanitize TERM:
safe_term=${TERM//[^[:alnum:]]/?}
match_lhs=""

[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
    && $(dircolors -p > $HOME/.dir_colors)

unset match_lhs
use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		#PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
        PS1='\[\e[1;92m\]\h\[\e[m\] \[\e[1;94m\]\W\[\e[m\] \[\e[1;91m\]$(parse_git_branch)\[\e[m\]\[\e[1;92m\]\$\[\e[m\] \[\e[0;37m\]'
	else
		#PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] '
        PS1='\[\e[1;92m\]\u@\h\[\e[m\] \[\e[1;94m\]\W\[\e[m\] \[\e[1;91m\]$(parse_git_branch)\[\e[m\]\[\e[1;92m\]\$\[\e[m\] \[\e[0;37m\]'
	fi

else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we do not have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \W \$ '
	fi
fi

PS2='> '
PS3='> '
PS4='+ '
# }}}

#set -o vi 	# Shell is vi mode

# {{{ fbterm
#	---> fbterm <----
#if [ "$TERM" = "linux" ]; then
#	alias fbterm='LANG=zh_CN.UTF-8 fbterm'
# 	fbterm
#fi
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

### {{{ PS1 GIT
if [[ $PS1 && -f /usr/share/git/git-prompt.sh ]]; then
    source /usr/share/git/git-prompt.sh

    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1

    if $use_color; then
        PS1='\[\e[1;92m\]\u\[\e[m\] \[\e[1;94m\]\W\[\e[m\] \[\e[1;91m\]$(__git_ps1 "(%s)")\[\e[m\]\[\e[1;92m\]\$\[\e[m\] \[\e[0;37m\]'
    else
        PS1='\u \W $(__git_ps1 "(%s)")\$ '
    fi
fi
unset use_color
# }}} PS1 GIT End

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
export PATH=$PATH:$HOME/.bin:$HOME/Dev_Env/3.4.1/bin

# add ARM environment
if [ -d "$HOME/Dev_Env/3.4.1/bin" ] ; then
    PATH="$HOME/Dev_Env/3.4.1/bin:$PATH"
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

[ -f $HOME/.bin/z.sh ] && source $HOME/.bin/z.sh
[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases
[ -f $HOME/.bashrc.local ] && source $HOME/.bashrc.local

#export PROMPT_COMMAND="echo -n [$(date +%k:%m:%S)]"
echo "home: .bashrc: $mysystem" >> ~/x
