test ! -z "$DEBUG" && echo './init.ksh'
# initialization
. ./pushd.ksh
. ./import.ksh

#--- import modules ----
import_dir lib              #common ksh functions and string operations
import_dir aliases          #generic aliases for any system
import_dir os_specific      #system-specific functions and workarounds
import_dir tool_specific    #configuration options for important tools
import_dir ps_config        #final visual touches and minor qol stuff
# ...
# add more of your own custom directories below

#export ARCH="$(get_arch)"
#export CONTEXT="$(get_host)"

# This is here to support shells that do not respect set -o from
# within functions (e.g. AIX)
set -o vi

# Workaround for Solaris/HP-UX not supporting xterm-256color
#if infocmp > /dev/null 2>&1; then
    #:
#else
    #export TERM=xterm
#fi
