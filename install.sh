#!/usr/bin/env bash
#  Filename: install.sh
#   Created: 2013-04-22 23:34:09
#      Desc: Linux Configuration files
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself

mkdir -p "$HOME/workspace"
mkdir -p "$HOME/Music"
mkdir -p "$HOME/software"
mkdir -p "$HOME/.config"

# Create mpd dir tree
mkdir -p "$HOME/.mpd/playlists" && touch "$HOME"/.mpd/{db,log,pid,state,sticker.sql}

GIT_CLONE='git clone -q --depth 1'
oh_zsh_dir=$HOME/.oh-my-zsh
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

ok()    { echo -e " \033[1;32m✔\033[0m  $1"; 	}
tips()  { echo -e " \033[1;33m?\033[0m  $1";  }
skip()  { echo -e " \033[1;33m!\033[0m  $1";  }

link_file()
{
  overwrite_all=${overwrite_all:-false}
  backup_all=${backup_all:-false}
  skip_all=${skip_all:-false}

  local src=$1 dst=$2

  local overwrite backup skip action

  if [[ -e "$dst" ]]; then
    if [[ "$overwrite_all" == "false" && "$backup_all" == "false" && "$skip_all" == "false" ]]; then
      local currentSrc="$(readlink $dst)"

      if [[ "$currentSrc" == "$src" ]]; then
        skip=true
      else
        tips "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -rsn 1 action
        case "$action" in
          o ) overwrite=true;;
          O ) overwrite_all=true;;
          b ) backup=true;;
          B ) backup_all=true;;
          s ) skip=true;;
          S ) skip_all=true;;
          * ) ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    [[ "$overwrite" == "true" ]] && rm -rf "$dst" && ok "removed $dst"
    [[ "$backup" == "true" ]] && mv "$dst" "${dst}.backup" && ok "moved $dst to ${dst}.backup"
    [[ "$skip" == "true" ]] && skip "skipped $src"
  fi

  # "false" or empty
  [[ "$skip" != "true" ]] && ln -s "$1" "$2" && ok "linked $1 to $2"
}

do_link_dir()
{
  local src_dir=$1 dst_dir=$2 filter=$3

  for src in `ls $src_dir $filter`
  do
    link_file "$src_dir$src" "$dst_dir$src"
  done
}

config_zsh()
{
  set -i "s|ZSH=.*|ZSH=$oh_zsh_dir|g" "$DOTFILES_DIR"/zshrc
  [ -d "$oh_zsh_dir" ] && return
  $GIT_CLONE https://github.com/robbyrussell/oh-my-zsh.git "$oh_zsh_dir"

  # Plugins
  local plugin_dir="$oh_zsh_dir"/custom/plugins
  $GIT_CLONE https://github.com/zsh-users/zsh-syntax-highlighting "$plugin_dir"/zsh-syntax-highlighting
  $GIT_CLONE https://github.com/zsh-users/zsh-autosuggestions     "$plugin_dir"/zsh-autosuggestions
  $GIT_CLONE https://github.com/djui/alias-tips                   "$plugin_dir"/alias-tips
  # $GIT_CLONE https://github.com/zsh-users/zsh-completions         "$plugin_dir"/zsh-completions
}

main()
{
  local overwrite_all=false backup_all=false skip_all=false

  do_link_dir $HOME/.dotfiles/ $HOME/. '-I ssh -I config -I README.md -I install.sh'
  do_link_dir $HOME/.dotfiles/config/ $HOME/.config/

  [ ! -e ~/.git-prompt.sh ] && curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh

  config_zsh
}

main

echo ''
echo '  All installed!'
