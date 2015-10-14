# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
# ZSH_THEME="sorin"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

##在命令前插入 sudo {{{
#定义功能
sudo-command-line() {
[[ -z $BUFFER  ]] && zle up-history
[[ $BUFFER != sudo\ *  ]] && BUFFER="sudo $BUFFER"
zle end-of-line #光标移动到行末

}
zle -N sudo-command-line

#定义快捷键为： [Esc][Esc]
bindkey "\e\e" sudo-command-line
#}}}

#RELEASE=`lsb_release -i |awk '{print $3}'`

#if [[ ${RELEASE} == "Ubuntu" ]];
#then
	#if [ ! -f "$HOME/.dir_colors" ];then
		#dircolors -p > $HOME/.dir_colors
	#else
		#eval `dircolors -b $HOME/.dir_colors`
	#fi
#fi

#---------------------------------------------------------------
# User specific aliases and functions
#---------------------------------------------------------------
alias tmux='tmux -2'

# ls
alias ls='ls --color'
alias ll='ls -l'
alias lll='ls -Alh --sort=size . | tr -s " " | cut -d " " -f 5,9'
alias la='ls -Al'               # Show hidden files
alias lx='ls -lXB'              # Sort by extension
alias lk='ls -lSr'              # Sort by size
alias lc='ls -lcr'				# Sort by modification time
alias lu='ls -lur'				# Sort by access time
alias lr='ls -lR'               # Recursion ls
alias lt='ls -ltr'              # Sort by date
alias lm='ls -al |more'
alias tree='tree -C'			# tree display color

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# safety features
alias rm='rm -i'
#alias cp='cp -i'
alias mv='mv -i'

# new commands
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hg='history | grep $1' 	# requires an argument
alias pg='ps aux|head -1; ps aux | grep -v "grep" | grep $1 '
alias openports='netstat --all --numeric --programs --inet'

# cd
alias ..='cd ..'
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias ~="cd ~"
alias -- -="cd -"

# vim
alias e='vim'
alias vi='vim'

# path
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

# scrot
alias scrots='scrot -s' 	# Crawl selection area
alias scrotbs='scrot -bs' 	# Crawl window
alias screenshot='gnome-screenshot --interactive'

alias cls='clear'

alias cman='man -M /usr/share/man/zh_CN'
alias indent='indent -npro -gnu -i4 -ts4 -sob -l200 -ss -bl -bli 0 -npcs -npsl'
alias gmplayer='gnome-mplayer'
alias ai="sudo apt-get install"
alias markdown='markdown --html4tags'
alias dstat='dstat -cdlmnpsy'
alias ping='ping -c 3'
alias lock-screen="gnome-screensaver-command -a"
alias diff='diff -urNwB'

alias pserver='python -m SimpleHTTPServer'
alias jserver="jekyll --server"

alias mkdir='mkdir -p'
alias j='jobs -l'
alias which='type -a'

# Assumes LPDEST is defined (default printer)
#alias pjet='enscript -h -G -fCourier9 -d $LPDEST'
#Pretty-print using enscript

alias du='du -kh'        # Makes a more readable output.
alias df='df -kTh'

#----------------------------------------------------------
# Make the following commands run in background automatically:
#----------------------------------------------------------

mkcd()
{
	mkdir $1;
	cd $1;
}

exz () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1    ;;
      *.tar.gz)    tar xzf $1    ;;
      *.bz2)       bunzip2 $1    ;;
      *.rar)       rar x $1      ;;
      *.gz)        gunzip $1     ;;
      *.tar)       tar xf $1     ;;
      *.tbz2)      tar xjf $1    ;;
      *.tgz)       tar xzf $1    ;;
      *.zip)       unzip $1      ;;
      *.Z)         uncompress $1 ;;
      *.7z)        7z x $1       ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function te()  # Wrapper around xemacs/gnuserv ...
{
	if [ "$(gnuclient -batch -eval t 2>&-)" == "t" ]; then
		gnuclient -q "$@";
	else
		( xemacs "$@" &);
	fi
}

function soffice()      { command soffice "$@" & }
function firefox()      { command firefox "$@" & }
function evince()       { command evince "$@" & }
function eog()          { command eog "$@" & }
function openoffice()   { command openoffice.org "$@" & }
function acroread()     { command acroread "$@" & }

#--------------------------------------------------------
#			set
#--------------------------------------------------------
#set -o vi 	# Shell is vi mode

#------------- fbterm -----------------------------------
#	---> fbterm <----
#if [ "$TERM" = "linux" ]; then
#	alias fbterm='LANG=zh_CN.UTF-8 fbterm'
# 	fbterm
#fi

#--------- colorful man page ------------------------------
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#------------------ fcitx ------------------------------
#	in .zprofile

#----------- Enrironment Variable -----------------------
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=erasedups

export EDITOR="vim"
#export LESS="-R"

[[ -f ~/.dircolor_dark ]] && eval $(dircolors -b ~/.dircolor_dark)

# welcome
#echo -ne "\E[01;31m Good Morning, `whoami`! It's "; date '+%A, %B %-d %Y'; uptime
