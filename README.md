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

<br />
For for module development
__import_log "your message" to send a message to the user on the first login of their days, separate from the greetings message(i.e. a diagnostics msg pops up if it exists)

<br />
<br />

--------

TODO:
* More cool bash networking tricks
* Randomized Login Messages
  * Randomized Login Ascii Art
* Integrate this with some stupid webapi (for linux webapp?)
* More stuff related to c++ development
* More linux notes
