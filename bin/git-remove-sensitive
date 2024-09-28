#!/usr/bin/env bash
#  Filename: git-remove-sensitive.sh
#   Created: 2016-12-24 15:39:40
#      Desc: Remove sensitive data
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself

git filter-branch --force --index-filter "git rm -r --cached --ignore-unmatch $*" --prune-empty --tag-name-filter cat -- --all
git push origin --force --all
git push origin --force --tags

git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now
