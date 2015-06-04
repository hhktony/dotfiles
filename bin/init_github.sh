#!/usr/bin/env bash

USER_NAME="hhktony"

if [ "$#" -ne "1" ];then
    echo "Usage: `basename $0` <repo>"
    exit 1;
fi

git remote add origin git@github.com:$USER_NAME/$1.git
git push origin master
git config branch.master.remote origin
git config branch.master.merge refs/heads/master
git config push.default current
