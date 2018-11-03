#base PS1
#export PS1="\[\e[0;32m\][\h:\w]\$\[\e[m\] "
#export PS1="$PWD>"
#export PS1="${HOSTNAME}:\${PWD##*/} \$ "
#export PS1='$(print -n "`id -un`@`hostname`:";if [[ "${PWD#$HOME}" != "$PWD" ]] then; print -n "~${PWD#$HOME}"; else; print -n "$PWD";fi;print "\n$ ")'
#export PS1="\[\e[0;32m\][\h:\w]\$\[\e[m\] "
#export PS1='$(printf "wow\n")'
#export PS1='$(printf "%s`hostname` `id -un`@ if [[ ! -z "git rev-parse --abbrev-ref HEAD" ]] then; print -n "~${PWD#$HOME}"; else; print -n "$PWD";fi;print "\n$ ")'
#export PS1='$(print)'


if type cleartool >/dev/null 2>/dev/null; then
    #insert current clearcase view if applicable
    view=$(ct pwv -short)
    if [[ "$view" != "** NONE **" ]]; then
        #export PS1=$(ps1_prepend "($view)")
        export PS1="($view) $PS1"
    fi
fi

#if type git >/dev/null 2>/dev/null; then
#    #insert current clearcase view if applicable
#    branch=$(git rev-parse --abbrev-ref HEAD)
#    if [[ ! -z $branch ]]; then
#        #export PS1=$(ps1_prepend "($view)")
#        export PS1="($branch) $PS1"
#    fi
#fi
__git_ps1(){
    __branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ ! -z $__branch ]]; then
        printf "($__branch)"
    fi
}

export PS1='$(__git_ps1)'"$PS1"

#finally, make sure to trap interrupts
trap 2 15
