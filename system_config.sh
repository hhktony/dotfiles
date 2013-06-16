#!/usr/bin/env bash

#============================================================================================
#
#         FileName: system_config.sh
#
#      Descriptions:
#
#          Version: 1.0
#          Created: 2013-04-22 23:34:09
#         Revision: (none)
#
#           Author: xutao(mark), butbueatiful@gmail.com
#          Company: wanwei-tech
#
#============================================================================================

if [ $# = 0 ]; then
    printf "\e[01;033mUsage: $0 <sys/file/vim>\e[0m\n\n"
    exit 1
fi

[[ ! -d "$HOME/software/" ]] &&  mkdir $HOME/software
 
function conf_sys
{
    rm -rf $HOME/.oh-my-zsh

    git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

    conf_file
    conf_vim
}

function conf_file
{
    cd $HOME/.dotfiles

    for name in *
    do
        if [[ $name == "config" ]]; then
            cd config

            for cname in *
            do
                target="$HOME/.config/$cname"
                rm -rf ${target}
                ln -s "$PWD/$cname" "$target"
            done
            cd ..
        else
            target="$HOME/.$name"
            rm -rf ${target}
            ln -s "$PWD/$name" "$target"
        fi
    done

    FILENAME=`basename $0`
    rm -rf $HOME/.$FILENAME $HOME/.README.md
}

function conf_vim
{
    cd $HOME
    rm -rf .vim .vimrc .gvimrc

    git clone git@github.com:ButBueatiful/dotvim.git .vim
    cd $HOME/.vim 	
    ./config.sh
}

if [ "$1" = "sys" ]
then
    conf_sys
elif [ "$1" = "vim" ]
then
    conf_vim
elif [ "$1" = "file" ]
then
   conf_file 
else
    echo "Nothing to do!"
fi
