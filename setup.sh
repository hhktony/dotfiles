#!/usr/bin/env bash
#  Filename: setup.sh
#   Created: 2013-04-22 23:34:09
#      Desc: mydotfiles
#    Author: xutao(Tony Xu), butbueatiful@gmail.com
#   Company: myself

help_info ()
{
    printf "\e[01;033mUsage: \n\t$0 <sys/file/vim/emacs>\e[0m\n\n"
    exit 1
}

[[ ! -d "$HOME/workspace" ]]  		&& mkdir $HOME/workspace
[[ ! -d "$HOME/Music" ]]      		&& mkdir $HOME/Music
[[ ! -d "$HOME/.config" ]]    		&& mkdir $HOME/.config

do_link_files()
{
    local dst_prefix=$1
    local src_dir=$2
    local filter=$3

    for i in `ls $src_dir $filter`
    do
        if [ -e $dst_prefix$i ]; then
            printf "\e[01;033mWARNING: \'$dst_prefix$i\' already exists!\nDo you want to delete it? (y|n) \e[0m"
            read result
            if [ $result = y ]; then
                rm -rf $dst_prefix$i
            else
                continue
            fi
        fi

        ln -s $src_dir$i $dst_prefix$i
        printf "\e[01;034mOK: \'$src_dir$i\' linked to \'$dst_prefix$i\'\e[0m\n"
    done
}

conf_file()
{
    do_link_files $HOME/. $HOME/.dotfiles/ '-I config -I README.md -I setup.sh'
    do_link_files $HOME/.config/ $HOME/.dotfiles/config/
}

conf_sys ()
{
    conf_file
    conf_emacs
    conf_vim
}

conf_sys ()
{
    conf_file
    conf_emacs
    conf_vim
}

conf_vim ()
{
    cd $HOME
    rm -rf .vim .vimrc .gvimrc

    git clone git@github.com:ButBueatiful/dotvim.git .vim

    cd $HOME/.vim
    ./setup.sh
}

conf_emacs ()
{
    cd $HOME

    git clone git@github.com:ButBueatiful/emacs.d .emacs.d
}

case $1 in
    sys)
        conf_sys    ;;
    file)
        conf_file   ;;
    vim)
        conf_vim    ;;
    emacs)
        conf_emacs  ;;
    *)
        help_info
        exit 1
esac

exit 0
