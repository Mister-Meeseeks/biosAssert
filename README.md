# biosAssert
BIOS state book-keeping that hooks into automated config management

## Purpose

Deploying bare-metal servers using automated configuration management tools, like
Chef or Puppet, can be ackward. In particular certain changes need to be made to 
hardware pre-boot. This usually can't be done from inside the O/S, and requires
manual intervention outside automated configuration. 

This tool assists in tracking when these changes need to be made. The program itself
does not change any BIOS or pre-boot parameters, and relies on manual intervention to do
so. However what the program does do is assist the user, by storing both previously set
as well as pending staged changes. This logic allows for mostly automated configuration
that only "shells out" at the point where manual intervention is absolutely required.

## Workflow

The BIOS "configuration" files used by the program are nothing more than human readable
plaintext instructions for setting up the BIOS. These configs can be staged to servers
in an automated fashion. biosAssert checks the existing BIOS configuration state against
the staged state. If no changes are required the program runs quietly without error.

In the case of a required change, the assert program will exit with error. From a config
management standpoint, than should trigger a fatal failure which alerts the sysadmin. From
there the sysadmin can check the pending configuration, making the instructed changes at
reboot. The sysadmin manually promotes the changes to indicate that they're currently set.
bios assert will run without error until a different staged configuration is pushed.

## Shell Commands

There are four valid commands:

````bios assert```` - Checks for any pending configuration changes to be made. If not, exits
silently without 0 return code. Otherwise prints pending instructed changes to user, and exits
with error return code.

````bios stage [config path]```` - Stages the config found as the pending pre-boot changes to be 
made. If you re-stage a replicate of your already current config, program will register that as
no changes to be configured.

```bios empty```` - Stages an empty config. Useful for indicating that no bios configuration is
necessary at this time. If current config is already empty will register as no changes to be made.
Otherwise, non-empty curent config will require a trivial call to promote.

````bios promote```` - For correct tracking, only run *after* manual pre-boot changes have been
made. Will prompt the user to re-confirm that currently pending changes have been properly 
implemented. After invocation, will register as no changes needed until a different configuration
is staged.


