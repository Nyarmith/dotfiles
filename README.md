# Portable KSH
This directory is meant to be a standalone set of ksh functions and aliases primarily for older versions. The ksh directory can be located anywhere (e.g. some random network drive) , all you need to do is change to the base directory and source the init.ksh file to populate your current session. If you have the permissions, you can also source init.ksh from your machine's kshrc.   

sourcing means this: `. ./init.ksh`, which I was told is more portable between ksh versions than the source command
