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

warn() { 
	printf "\r  [\033[0;33mWARN\033[0m] $1\n" 
} 

ok() { 
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n" 
} 

do_link_files() {
	local dst_prefix=$1 src_dir=$2 filter=$3

	dotfiles=$(ls $src_dir $filter)
	for item in `ls $src_dir $filter`
	do
		if [[ -e $dst_prefix$item ]]; then
			warn "$dst_prefix$item already exiets!\n    Do you want to delete it? (y|n)"
			read result
		  [[ $result = y ]] && rm -rf $dst_prefix$item || continue
		fi

		ln -s $src_dir$item $dst_prefix$item
    ok "$src_dir$item linked to $dst_prefix$item"
	done
}

conf_file() {
	do_link_files $HOME/. $HOME/.dotfiles/ '-I config -I README.md -I install.sh'
	do_link_files $HOME/.config/ $HOME/.dotfiles/config/
	git clone https://github.com/hhktony/oh-my-zsh.git $HOME/.oh-my-zsh --depth=1
}

conf_sys() {
	conf_file
	conf_emacs
	conf_vim
}

conf_vim() {
	cd $HOME
  rm -rf .vim .vimrc .gvimrc

  git clone git@github.com:hhktony/dotvim.git .vim

	cd $HOME/.vim
	./install.sh
}

conf_emacs() {
	cd $HOME
	git clone git@github.com:hhktony/emacs.d .emacs.d
}

case $1 in
	--help)
			help_info
			exit 0
			;;
	--all)   conf_sys   ;;
	--file)  conf_file  ;;
	--vim)   conf_vim   ;;
	--emacs) conf_emacs ;;
	*)
			echo "unknown option: $1"
			help_info
			exit 1
			;;
esac

exit 0
