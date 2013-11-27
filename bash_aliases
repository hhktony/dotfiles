# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# GNU ls color
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -Al'               # Show hidden files
alias lx='ls -lXB'              # Sort by extension
alias lk='ls -lSr'              # Sort by size
alias lc='ls -lcr'				# Sort by modification time
alias lu='ls -lur'				# Sort by access time
alias lr='ls -lR'               # Recursion ls
alias lt='ls -ltr'              # Sort by date
alias lm='ls -al |more'
alias lsd='ls -lF | grep "^d"'
alias tree='tree -C'			# tree display color

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm.sh'
alias rm!='/bin/rm'

# new commands
alias da='date "+%A, %B %d[%V], %Y [%T]"'
alias du1='du --max-depth=1'
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

# privileged access
if [ $UID -ne 0 ]; then
alias sudo='sudo '
    alias scat='sudo cat'
    alias svim='sudo vim'
    alias root='sudo su'
    alias reboot='sudo reboot'
    alias halt='sudo halt'
    alias update='sudo pacman -Su'
    alias netcfg='sudo netcfg2'
fi

alias e='vim'
alias et='TERM=xterm-256color emacsclient -t -a ""'
alias ec='emacsclient -c -a ""'
alias cls='clear'
alias q='exit'
alias vi='vim'
alias tmux='tmux -2'
alias g='git'

# path
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

# scrot
alias scrots='scrot -s' 	# Crawl selection area
alias scrotbs='scrot -bs' 	# Crawl window
alias screenshot='gnome-screenshot --interactive'

alias cman='man -M /usr/share/man/zh_CN'
alias indent='indent -npro -gnu -i4 -ts4 -sob -l80 -ss -bl -bli0 -npcs -npsl'
alias indentkr='indent -npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1'
alias gmplayer='gnome-mplayer'
alias markdown='markdown --html4tags'
alias dstat='dstat -cdlmnpsy'
alias ping='ping -c 3'
alias lock-screen="gnome-screensaver-command -a"
alias rbashrc='source ~/.bashrc'
alias diff='diff -urNwB'

alias pserver='python -m SimpleHTTPServer'
alias jserver="jekyll --server"

alias mkdir='mkdir -p'
alias which='type -a'

#alias print='/usr/bin/lp -o nobanner -d $LPDEST'

# Assumes LPDEST is defined (default printer)
#alias pjet='enscript -h -G -fCourier9 -d $LPDEST'
#Pretty-print using enscript

alias du='du -sh'        # Makes a more readable output.
alias df='df -kTh'

#---------------------------------------------------------------
#  spelling typos - highly personnal and keyboard-dependent :-)
#---------------------------------------------------------------
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'
alias mkea='make'
alias mkae='make'

#----------------------------------------------------------
# Make the following commands run in background automatically:
#----------------------------------------------------------

function mkcd()
{
	mkdir $1;
	cd $1;
}

function exz()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       rar x $1       ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function pcz()
{
    if [ $1 ] ; then
        case $1 in
            tbz)    tar cjvf $2.tar.bz2 $2      ;;
            tgz)    tar czvf $2.tar.gz  $2      ;;
            tar)    tar cpvf $2.tar  $2         ;;
            bz2)    bzip $2                     ;;
            gz)     gzip -c -9 -n $2 > $2.gz    ;;
            zip)    zip -r $2.zip $2            ;;
            7z)     7z a $2.7z $2               ;;
            *)     echo "'$1' Cannot be packed via pack()" ;;
        esac
    else
            echo "'$1' is not a valid file"
    fi
}

function calc()
{
    echo "$*" | bc;
}

function te()  # Wrapper around xemacs/gnuserv ...
{
	if [ "$(gnuclient -batch -eval t 2>&-)" == "t" ]; then
		gnuclient -q "$@";
	else
		( xemacs "$@" &);
	fi
}

function soffice()  { command soffice "$@" & }
function firefox()  { command firefox "$@" & }
function openoffice() { command openoffice.org "$@" & }
function acroread() { command acroread "$@" & }
function evince()   { command evince "$@" & }
function apvlv()    { command apvlv "$@" & }
function zathura()  { command zathura "$@" & }
function eog()      { command eog "$@" & }

[ -f $HOME/.bash_aliases_local ] && . $HOME/.bash_aliases_local
