# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ZSH_THEME="hhktony"
# TODO(hhktony)
eval "$(starship init zsh)"

# if type brew &>/dev/null
# then
#   FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
#   # oh-my-zsh not need
#   autoload -Uz compinit
#   compinit
# fi

export OH_ZSH_HOME=$HOME/.oh-my-zsh
# ZSH_THEME="powerlevel10k/powerlevel10k"
# zmodload zsh/zprof
# alias tt="\time zsh -i -c exit"

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
  # gitfast
  # git-extras
  emoji
  F-Sy-H
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
  # pyenv # TODO: slow
  # django
  # kubectl
)

# /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
if [[ $(uname -s) == "Darwin" ]]; then
  HOMEBREW_PREFIX=$(brew --prefix)
  export HOMEBREW_NO_AUTO_UPDATE=
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
  export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
  export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/bottles"
  export PATH="$HOMEBREW_PREFIX/opt/uutils-coreutils/libexec/uubin:$PATH"
  export PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
  FPATH=$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH

  if command -v $HOMEBREW_PREFIX/bin/vim >/dev/null; then
    alias vi=$HOMEBREW_PREFIX/bin/vim
    alias vim=$HOMEBREW_PREFIX/bin/vim
    alias vimdiff=$HOMEBREW_PREFIX/bin/vimdiff
    export EDITOR=$HOMEBREW_PREFIX/bin/vim
  fi
  # export PATH=/usr/local/opt/grep/libexec/gnubin:$PATH
  # export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  # export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

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

# [[ -d $HOME/.bin ]] && export PATH=$HOME/.bin:$PATH
[[ -f $HOME/.shrc_local ]] && source $HOME/.shrc_local
[[ -f $HOME/.shrc ]] && source $HOME/.shrc

# welcome
# echo -ne "Hi, `whoami`! It's "; date '+%A, %B %-d %Y'; uptime
echo -ne ""

source /Users/xutao/.config/broot/launcher/bash/br

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim: set ft=zsh syn=sh sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
