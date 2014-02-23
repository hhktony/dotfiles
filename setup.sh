#!/usr/bin/env bash
#set -x

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

help_info ()
{
    printf "\e[01;033mUsage: \n\t$0 <sys/file/vim/emacs>\e[0m\n\n"
    exit 1
}

[[ ! -d "$HOME/Software/" ]] &&  mkdir $HOME/Software
[[ ! -d "$HOME/Workspace/" ]] && mkdir $HOME/Workspace
[[ ! -d "$HOME/Music" ]] && mkdir $HOME/Music
[[ ! -d "$HOME/.config/" ]] && mkdir $HOME/.config
 
conf_sys ()
{
    conf_file
    conf_emacs
    conf_vim
}

conf_file ()
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
                ln -s "$PWD/$cname" "$target" > /dev/null 2>&1
            done
            cd ..
        else
            target="$HOME/.$name"
            rm -rf ${target}
            ln -s "$PWD/$name" "$target" > /dev/null 2>&1
        fi
    done

    FILENAME=`basename $0`
    rm -rf $HOME/.$FILENAME $HOME/.README.md
}

conf_vim ()
{
    cd $HOME
    rm -rf .vim .vimrc .gvimrc

    git clone git@github.com:ButBueatiful/dotvim.git .vim

    cd $HOME/.vim 	
    ./config.sh
}

conf_emacs ()
{
    cd $HOME

    git clone git@github.com:ButBueatiful/emacs.d .emacs.d
}

case $1 in
    sys)    conf_sys    ;;
    file)   conf_file   ;;
    vim)    conf_vim    ;;
    emacs)  conf_emacs  ;;
    *)      help_info   ;;
esac
