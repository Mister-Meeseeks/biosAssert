#!/bin/bash -eu

repoDir=$(dirname $(readlink -f $0))

src=$repoDir/bios
target=/usr/local/bin/bios

if [[ -e $target ]] ; then
    rm $target
elif [[ -L $target ]] ; then
    unlink $target
fi

ln -s $src $target

