#!/usr/bin/env bash
#  Filename: uptags.sh
#   Created: 2013-12-25 00:13:25
#      Desc: update tags file
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself

if [ -e /usr/bin/ctags ]; then
    ctags_exe=/usr/bin/ctags
elif [ -e /usr/bin/ctags-exuberant ]; then
    ctags_exe=/usr/bin/ctags-exuberant
else
    echo "Please install ctags or ctags-exuberant!"
    exit
fi

get_proj_root_dir ()
{
    gitroot=`git rev-parse --show-toplevel 2>/dev/null`
    [[ -z $gitroot ]] && gitroot=.
}

function updatetags ()
{
    cd $gitroot
    $ctags_exe -R --fields=+iaS --extra=+q
}

get_proj_root_dir
updatetags
