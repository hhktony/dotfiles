# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ZSH_THEME="hhktony"
eval "$(starship init zsh)"
export OH_ZSH_HOME=$HOME/.oh-my-zsh
# ZSH_THEME="powerlevel10k/powerlevel10k"
# zmodload zsh/zprof
# alias tt="\time zsh -i -c exit"

[[ -f $HOME/.shrc ]] && source $HOME/.shrc
[[ -f $HOME/.shrc_local ]] && source $HOME/.shrc_local

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"
# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"
#
# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

plugins=(
  z.lua
  # gitfast
  # git-extras
  emoji
  fast-syntax-highlighting
  zsh-autosuggestions
  alias-tips
  docker
  sudo
  # pip
  # golang
  # git-flow
  # docke-compose
  # kubectl
  # npm
  # nvm
  pyenv # TODO: slow
  # django
  # kubectl
)

source $OH_ZSH_HOME/oh-my-zsh.sh

# bindkey -v  # VIM mode

# History {{{
HISTFILE=$HOME/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
# }}}

[[ -d $HOME/.bin ]] && export PATH=$HOME/.bin:$PATH
# welcome
# echo -ne "\E[01;31m Hi, `whoami`! It's "; date '+%A, %B %-d %Y'; uptime

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ls='ls --color=tty'
