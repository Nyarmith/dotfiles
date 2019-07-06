# this lets programs that support the XDF_CONFIG spec find their condig files
export XDG_CONFIG_HOME="$(pwd)/config"

# vim does not support it, so this is a workaround hack
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

export EDITOR=vi

declare -Ag fgcol
declare -Ag bgcol
if hash tput 2> /dev/null; then
    colorArr=(black red green yellow blue magenta cyan white)
    for color in {0..7}; do
        fgcol[${colorArr[$color]}]="$(tput setaf $color)"
        bgcol[${colorArr[$color]}]="$(tput setab $color)"
    done
    COL_WARN="${fgcol["black"]}${bgcol["yellow"]}"
    COL_ERR="${fgcol["blue"]}${bgcol["red"]}"
    COL_OK="${fgcol["green"]}${bgcol["white"]}"
    COL_OFF="$(tput sgr0)"
    COL_ON=1
    unset colorArr
    unset color
fi

export fgcol
export bgcol

set -o vi
