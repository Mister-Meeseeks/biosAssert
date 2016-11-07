#!/bin/bash -eu

function promptCorrect() {
    cat <<EOF
BiosAssert Prompt: 
  You've indicated that the currently staged parameters have been put into
  effect at BIOS configuration. Before continuing please carefully review
  the below parameters to double-check that the changes were correctly and
  completely made:
==========================================================================
EOF
    cat $biosStageCfg
    cat <<EOF
==========================================================================
EOF
    promptYesNo "Have the above changes to BIOS been properly made?"
}

function promptYesNo() {
    local promptText="$1"
    while true; do
	read -p "$promptText [y/n]" yn
	case $yn in
            [Yy]* ) return 0;;
	    [Nn]* ) return 1;;
	    * ) echo "Please answer yes or no.";;
	esac
    done
}


function promoteStaged() {
    cp $biosStageCfg $biosCfg
}

function warnNoChange() {
    cat >&2 <<EOF
BiosAssert Warning:
  No changes made. Staged config was not promoted.
EOF
}

function promoteIfConfirmed() {
    if promptCorrect; then
	promoteStaged
    else
	warnNoChange
    fi
}

function assertHasStaged() {
    if [[ ! -e $biosStageCfg ]] ; then
	cat >&2 <<EOF
BiosAssert Error:
  No staged configuration to be promoted. No changes made.
EOF
	exit 1
    fi
}

assertHasStaged
promoteIfConfirmed
