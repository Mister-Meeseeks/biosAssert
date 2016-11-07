#!/bin/bash -eu

scriptDir=$(dirname $(readlink -f $0))
. $scriptDir/paths.sh

if [[ $# -eq 0 ]] ; then
    cmdType=assert
else
    cmdType=$1
    shift 1
fi

function sanitizeCommandArg() {
    local cmdType=$1
    echo $cmdType | sed 's/^[-]*//g'
}

function formScriptPath() {
    local $cmdType=$1
    echo $scriptDir/$(sanitizeCommandArg $cmdType).sh
}

function assertExists() {
    local cmdName=$1
    local cmdPath=$2
    if [[ ! -e $cmdPath ]] ; then
	echo "BiosAssert Error: Invalid command '$cmdName'. Try --help" >&2
	exit 1
    fi
}

function retrieveScriptPath() {
    local cmdType=$1
    local cmdPath=$(formScriptPath $cmdType)
    assertExists $cmdType $cmdPath
    echo $cmdPath
}

cmdScript=$(retrieveScriptPath $cmdType)

$cmdScript $*


