#!/bin/bash

scriptDir=$(dirname $(readlink -f $0))

$scriptDir/stage.sh /dev/null
