#!/usr/bin/env bash
#  Filename: install.sh
#   Created: 2013-04-22 23:34:09
#      Desc: my dotfiles
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself

[[ ! -d "$HOME/workspace" ]] && mkdir $HOME/workspace
[[ ! -d "$HOME/Music" ]]     && mkdir $HOME/Music
[[ ! -d "$HOME/software" ]]  && mkdir $HOME/software
[[ ! -d "$HOME/.config" ]]   && mkdir $HOME/.config

help_info() {
  cat << EOF
usage: $0 [OPTIONS]

    --help               Show this message
    --all                Install all config
    --file               Install all config, exclude emacs vim
    --vim                Install vim config
    --emacs              Install emacs config
EOF
}

info() {
  printf "\r  [\033[00;34mINFO\033[0m] $1\n"
}

ok() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

warn() {
  printf "\r  [\033[0;33mWARN\033[0m] $1\n"
}

link_file() {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then
    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then
      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then
        skip=true
      else
        warn "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      ok "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      ok "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      ok "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    ok "linked $1 to $2"
  fi
}

do_link_dir() {
  local dst_dir=$1 src_dir=$2 filter=$3
  local overwrite_all=false backup_all=false skip_all=false

  dotfiles=$(ls $src_dir $filter)
  for src in `ls $src_dir $filter`
  do
    link_file $src_dir$src $dst_dir$src
  done
}

install_dotfiles() {
  do_link_dir $HOME/. $HOME/.dotfiles/ '-I zsh bash config -I README.md -I install.sh'
  do_link_dir $HOME/.config/ $HOME/.dotfiles/config/
  do_link_dir $HOME/. $HOME/.dotfiles/bash/
  do_link_dir $HOME/. $HOME/.dotfiles/zsh/
  git clone https://github.com/hhktony/oh-my-zsh.git $HOME/.oh-my-zsh --depth=1
}

install_all() {
  install_dotfiles
  install_emacs
  install_vim
}

install_vim() {
  cd $HOME
  rm -rf .vim .vimrc .gvimrc

  git clone git@github.com:hhktony/dotvim.git .vim

  cd $HOME/.vim
  ./install.sh
}

install_emacs() {
  cd $HOME
  git clone git@github.com:hhktony/emacs.d .emacs.d
}

case $1 in
  --help )
      help_info
      exit 0
      ;;
  --all )
    install_all;;
  --file )
    install_dotfiles;;
  --vim )
    install_vim;;
  --emacs )
    install_emacs;;
  *)
    echo "unknown option: $1"
    help_info
    exit 1
    ;;
esac

echo ''
echo '  All installed!'
