chr() {
    if [ -z "$1" ] || (( "$1" > 256 )); then
        echo "usage: chr <ascii_num>"
        return 1;
    fi

    printf "\\$(printf %o "$1")"
}

ord() {
    [ -z "$1" ] && {
        echo "usage: ord <ascii_char>"
        return 1;
    }
    LC_CTYPE=C printf %d "'$1"
}

joins() {
    [[ -z "$2" ]] && {
        printf "Usage: joins <delim> <arg1> [arg2] ... [argN]"
        return 0
    }

    local delim="$1"
    local ret="$2"
    shift
    shift
    for val in "$@"; do
        ret="$ret$delim$ret"
    done
    printf "%s\n" "$ret"
}

pushv() {
    [[ -z "$2" ]] && {
        printf "Usage: pushv <var> <val>\n"
        return 0
    }

    local var="$1"
    if [[ -z ${!var} ]]; then
        declare -g $var="$2"
    else
        declare -g $var="${!var}:$2"
    fi
}

insv(){
    [[ -z "$2" ]] && {
        printf "Usage: insv <var> <val>\n"
        return 0
    }

    local var="$1"
    if [[ -z ${!var} ]]; then
        declare -g $var="$2"
    else
        declare -g $var="$2:${!var}"
    fi
}

popv(){
    [[ -z "$1" ]] && {
        printf "Usage: popv <var>\n"
        return 0
    }

    local var="$1"
    [[ -z "$var" ]] && return 0;
    local before="${!var}"
    declare -g $var=${!var%:*}
    [[ "$before" == "${!var}" ]] && declare -g $var=""
}

popfv(){
    [[ -z "$1" ]] && {
        printf "Usage: popv <var>\n"
        return 0
    }

    local var="$1"
    [[ -z "$var" ]] && return 0;
    local len1=${#var}
    declare -g $var=${!var#*:}
    [[ "$before" == "${!var}" ]] && declare -g $var=""
}

pappend() {
    pushv PATH "$1"
}

pprepend() {
    insv PATH "$1"
}

# note for arrays, you can simply do existingArr+=(additional elements)
# and deletion is ... ugh ... "${array[@]/$delete}"
