__git_ps1(){
    if [[ ! -z $__branch ]]; then
        printf "($__branch)"
    fi
}

__make_ps1(){
    local prevRet="$?"
    :
    local branch="$(printf "%.8s" "$(git rev-parse --abbrev-ref HEAD 2> /dev/null)")"
    [[ -n $branch ]] && branch=" ($branch)"
    local retStr=""
    local fmtStr=""
    if [[ -n $COL_ON ]]; then
        (( "$prevRet" )) && retStr="\[${fgcol[red]}\]${prevRet}\[${COL_OFF}\] "
        fmtStr="\[${fgcol[yellow]}\]\\\\u@\\\\h \[${fgcol[white]}\][\[${fgcol[magenta]}\]\\\\w\[${fgcol[white]}\]]\[${COL_OFF}\]%.12s %s"
    else
        (( "$prevRet" )) && retStr="${prevRet} "
        fmtStr="\\\\u@\\\\h [\\\\w]%.12s %s "
    fi
    printf "${fmtStr}\\$ " "$branch" "$retStr"
}

# https://stackoverflow.com/questions/19092488/custom-bash-prompt-is-overwriting-itself

PROMPT_COMMAND='PS1=$(__make_ps1)'
export PS2='.. '

#finally, make sure to trap interrupts
trap 2 15

