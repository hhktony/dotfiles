export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

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

plugins=(
  z
  git
  emoji
  zsh-syntax-highlighting
  zsh-autosuggestions
  alias-tips
  # git-flow
  zsh_reload
  docker
  # docke-compose
  sudo
  pip
  pyenv
  go
  # django
  nvm
  npm
  kubectl
)

source $ZSH/oh-my-zsh.sh

# export LESS="-R"

# [[ -f ~/.dircolor_dark ]] && eval $(dircolors -b ~/.dircolor_dark)
[[ -f $HOME/.shrc       ]] && source $HOME/.shrc
[[ -f $HOME/.shrc_local ]] && source $HOME/.shrc_local
[[ -d $HOME/.bin        ]] && export PATH=$PATH:$HOME/.bin

# welcome
# echo -ne "\E[01;31m Hi, `whoami`! It's "; date '+%A, %B %-d %Y'; uptime
#
