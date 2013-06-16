#!/usr/bin/env bash
set -x

aclocal
autoconf
autoheader
automake --foreign --add-missing --copy
