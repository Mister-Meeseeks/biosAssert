#!/bin/bash -eu

stageSrc=$1

function makeConfigDir() {
    mkdir -p $biosCfgDir
}

function copyToStaged() {
    local stageSrc=$1
    cp $stageSrc $biosStageCfg
}

function initCurrentCfg() {
    if [[ ! -e $biosCfg ]] ; then
	touch $biosCfg
    fi
}

makeConfigDir
copyToStaged $stageSrc
initCurrentCfg
