# Portable SH (formerly KSH)
This directory is meant to be a standalone set of sh functions and aliases primarily for older versions. The sh directory can be located anywhere (e.g. some random network drive) , all you need to do is change to the base directory and source the init.sh file to populate your current session. If you have the permissions, you can also source init.sh from your machine's *shrc.   


sourcing means this: `. ./init.sh`, which is portable due to not being bash-specific


as far as I know, there is no posix-compliant way to get the path of a script being sourced this way, so for users I suggest sourcing the dotfiles in your shellrc as follows:

```
__last=$(pwd)
cd /path/to/dotfiles/
. ./init.sh
cd $__last
unset __last
```
