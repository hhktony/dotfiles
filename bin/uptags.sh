#!/usr/bin/env bash

command -v ctags &>/dev/null || { echo >&2 "Please install ctags!"; exit 1; }

gitroot=$(git rev-parse --show-toplevel 2>/dev/null)
[[ -z $gitroot ]] && gitroot=.
cd $gitroot
ctags -R --fields=+iaS --extra=+q
