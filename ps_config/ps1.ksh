#base PS1
#export PS1="\[\e[0;32m\][\h:\w]\$\[\e[m\] "
export PS1='$PWD>'


if type cleartool >/dev/null 2>/dev/null; then
    #insert current clearcase view if applicable
    view=$(ct pwv -short)
    if [[ "$view" != "** NONE **" ]]; then
        #export PS1=$(ps1_prepend "($view)")
        export PS1="($view) $PS1"
    fi
fi


#finally, make sure to trap interrupts
trap 2 15
