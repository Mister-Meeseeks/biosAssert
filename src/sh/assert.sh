#!/bin/bash -eu

function assertHasConfig() {
    if [[ ! -e $biosCfg ]] ; then
	raiseConfigNeeded
    fi
}

function raiseConfigNeeded() {
    cat >&2 <<EOF
BiosAssert Error:
  BIOS state assertion failed due to config not being initialized. (Most
  likely this is a fresh install). To setup BiosAssert either run
  $ bios stage [path to bios config]
  ===OR===
  $ bios empty
EOF
    exit 1
}

function raiseUpdateNeeded() {
    cat >&2 <<EOF
BiosAssert Error:
  BIOS state asserion failed because configuration needs updating to the 
  below specification. Make necessary changes at boot time, restart, then run
  $ bios promote

BIOS config changes to be made, read carefully and mark down before rebooting:
==============================================================================
EOF
    cat $biosStageCfg >&2
    cat >&2 <<EOF
==============================================================================
EOF
    exit 1
}

function hasStagedUpdate() {
    [[ -e $biosStageCfg ]] && 
	     ! (cmp $biosStageCfg $biosCfg)
}

assertHasConfig
if hasStagedUpdate ; then
    raiseUpdateNeeded
fi

