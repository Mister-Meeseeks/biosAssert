#!/bin/bash -eu

cat <<EOF

BiosAssert: Program for server-level book-keeping of current and needed BIOS
            configurations.

The following commands are valid:

  $ bios assert  -  Checks current bios configurations for any pending staged
                    changes. Returns silently with 0 exit code if current. 
                    Otherwise prints to user changes to be made and exits with
                    error.
  $ bios stage [path to config]  
                 -  Use to stage pending changes to be made to BIOS config. If
                    config is different than current config, will cause assert
                    to fail until user indicates changes are made.
  $ bios empty   -  Stages an empty config. Useful for indicating that no 
                    specific BIOS requirements are in place at this time.
  $ bios promote -  Promotes staged config to current config. User should only 
                    run changing BIOS configuration at boot-time. Prompts user 
                    to check pending changes before marking changes as complete.
EOF
