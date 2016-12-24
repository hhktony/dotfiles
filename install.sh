#!/usr/bin/env bash
#  Filename: install.sh
#   Created: 2013-04-22 23:34:09
#      Desc: Linux Configuration files
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself

[[ ! -d "$HOME/workspace" ]] && mkdir $HOME/workspace
[[ ! -d "$HOME/Music" ]]     && mkdir $HOME/Music
[[ ! -d "$HOME/software" ]]  && mkdir $HOME/software
[[ ! -d "$HOME/.config" ]]   && mkdir $HOME/.config

# create mpd dir tree
[[ ! -d "$HOME/.mpd" ]] && mkdir -p $HOME/.mpd/playlists ; touch $HOME/.mpd/{db,log,pid,state,sticker.sql}

GIT_CLONE='git clone -q --depth 1'

ok()    { echo -e " \033[1;32m✔\033[0m  $@"; 	}
tips()  { echo -e " \033[1;33m?\033[0m  $@";  }
skip()  { echo -e " \033[1;33m!\033[0m  $@";  }

link_file()
{
  overwrite_all=${overwrite_all:-false}
  backup_all=${backup_all:-false}
  skip_all=${skip_all:-false}

  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [[ -e "$dst" ]]; then
    if [[ "$overwrite_all" == "false" && "$backup_all" == "false" && "$skip_all" == "false" ]]; then
      local currentSrc="$(readlink $dst)"

      if [[ "$currentSrc" == "$src" ]]; then
        skip=true
      else
        tips "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -s -n 1 action

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
  local dst_dir=$1 src_dir=$2 filter=$3

  dotfiles=$(ls $src_dir $filter)
  for src in `ls $src_dir $filter`
  do
    link_file $src_dir$src $dst_dir$src
  done
}

main()
{
  local overwrite_all=false backup_all=false skip_all=false

  do_link_dir $HOME/. $HOME/.dotfiles/ '-I ssh -I zsh -I bash -I config -I README.md -I install.sh'
  do_link_dir $HOME/.ssh/ $HOME/.dotfiles/ssh/
  do_link_dir $HOME/.config/ $HOME/.dotfiles/config/
  do_link_dir $HOME/. $HOME/.dotfiles/bash/

	[ ! -e ~/.git-prompt.sh ] && curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh

  # For zsh
  do_link_dir $HOME/. $HOME/.dotfiles/zsh/
  $GIT_CLONE  https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
  $GIT_CLONE  https://github.com/zsh-users/zsh-syntax-highlighting.git \
              $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  $GIT_CLONE  https://github.com/zsh-users/zsh-autosuggestions.git \
              $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
}

main

echo ''
echo '  All installed!'
