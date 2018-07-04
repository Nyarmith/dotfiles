test ! -z "$DEBUG" && echo './init.sh'

#set XDG_CONFIG home
export XDG_CONFIG_HOME="$(pwd)/config"
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# initialization
. ./pushd.sh
. ./import.sh
#--- import modules ----
import_dir lib              #common ksh functions and string operations
import_dir os_specific      #system-specific functions and workarounds
import_dir aliases          #generic aliases for any system
import_dir tool_specific    #configuration options for important tools
import_dir ps_config        #final visual touches and minor qol stuff
import_dir host_specific    #files speicifc to the host live here

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

. ./firstLogin.sh
