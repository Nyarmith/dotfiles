#!/usr/bin/env bash
test ! -z "$DEBUG" && echo './init.sh'

#set XDG_CONFIG home
export XDG_CONFIG_HOME="$(pwd)/config"
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

import_dir(){
    [ -z "$1" ] && printf "usage: import_dir <script_dir>\n"
    for file in ./${1}/*.sh; do
        source "$file"
    done
}

#--- import modules ----
import_dir lib
import_dir ps_config
import_dir aliases
import_dir tool_ext
import_dir os_specific
import_dir host_specific 2> /dev/null

set -o vi

# Workaround for Solaris/HP-UX not supporting xterm-256color
#if infocmp > /dev/null 2>&1; then
    #:
#else
    #export TERM=xterm
#fi

. ./firstLogin.sh
