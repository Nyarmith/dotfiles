#base PS1
#export PS1="\[\e[0;32m\][\h:\w]\$\[\e[m\] "
#export PS1="$PWD>"
#export PS1="${HOSTNAME}:\${PWD##*/} \$ "
#export PS1='$(print -n "`id -un`@`hostname`:";if [[ "${PWD#$HOME}" != "$PWD" ]] then; print -n "~${PWD#$HOME}"; else; print -n "$PWD";fi;print "\n$ ")'
#export PS1="\[\e[0;32m\][\h:\w]\$\[\e[m\] "
#export PS1='$(printf "wow\n")'
#export PS1='$(printf "%s`hostname` `id -un`@ if [[ ! -z "git rev-parse --abbrev-ref HEAD" ]] then; print -n "~${PWD#$HOME}"; else; print -n "$PWD";fi;print "\n$ ")'
#export PS1='$(print)'

#if type git >/dev/null 2>/dev/null; then
#    #insert current clearcase view if applicable
#    branch=$(git rev-parse --abbrev-ref HEAD)
#    if [[ ! -z $branch ]]; then
#        #export PS1=$(ps1_prepend "($view)")
#        export PS1="($branch) $PS1"
#    fi
#fi
__git_ps1(){
    if [[ ! -z $__branch ]]; then
        printf "($__branch)"
    fi
}

__make_ps1(){
    local prevRet="$?"
    :
    local branch="$(printf "%.8s" "$(git rev-parse --abbrev-ref HEAD 2> /dev/null)")"
    [[ -n $branch ]] && branch=" ($branch) "
    local retStr=""
    local fmtStr=""
    if [[ -n $COL_ON ]]; then
        (( "$prevRet" )) && retStr="${fgcol["red"]}${prevRet}${COL_OFF} "
        fmtStr="${fgcol["yellow"]}\\\\u@\\\\h${COL_OFF} [\\\\w]%.12s %s"
    else
        (( "$prevRet" )) && retStr="${prevRet} "
        fmtStr="\\\\u@\\\\h [\\\\w]%.12s %s "
    fi
    printf "${fmtStr}$ " "$branch" "$retStr"
}

PROMPT_COMMAND='PS1=$(__make_ps1)'
export PS2='.. '

#finally, make sure to trap interrupts
trap 2 15
