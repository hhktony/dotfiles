#!/usr/bin/env bash
#  Filename: uptags.sh
#   Created: 2013-12-25 00:13:25
#      Desc: TODO (some description)
#    Author: xutao(butbueatiful), butbueatiful@gmail.com
#   Company: myself

if [ -e /usr/bin/ctags ]; then
    ctags_exe=/usr/bin/ctags
elif [ -e /usr/bin/ctags-exuberant ]; then
    ctags_exe=/usr/bin/ctags-exuberant
else
    echo "Please install ctags or ctags-exuberant!"
    exit
fi

get_proj_root_dir () {
    local dir=.

    until [ "$dir" -ef $HOME ]; do
        # echo $dir
        [ -d "$dir/.git" ] && break
        dir="../$dir"
    done

    if [ "$dir" -ef $HOME ]; then
        proj_root_dir=.
    else
        proj_root_dir=`readlink -f $dir`
    fi
}

updatetags() {
    cd $proj_root_dir
    $ctags_exe -R --fields=+iaS --extra=+q
}

get_proj_root_dir
updatetags
