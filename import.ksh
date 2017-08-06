# "importing" another script is just sourcing it, but the sourced script
# can assume that they are located in the cwd. 
# Takes a relative path to the script to import.
# old-style function so that side-effects in lower functions (e.g. set -o vi) take effect
# in caller.
test ! -z "$DEBUG" && echo './import.ksh'

# repeat a value
repeat() {
    __repeat_val=$1
    __repeat_num=$2
    __repeat_acc=""
    while test $__repeat_num -gt 0; do
        __repeat_num=$(($__repeat_num - 1))
        __repeat_acc="$__repeat_acc$__repeat_val"
    done 
    echo "$__repeat_acc"
}

__import_debug() {
    test ! -z "$DEBUG" && echo $(repeat '-' $__import_indent) "$1"
}

__import_indent=0
import_script() {
    __import_target=$1
    # Remove first arg.
    shift
    __import_debug "Importing:     $__import_target"
    __import_debug "Current dir:   $(pwd)"
    pushd $(dirname $__import_target)
    __import_indent=$((__import_indent + 1))
    __import_debug "Execution dir: $(pwd)"
    . ./$(basename $__import_target) "$@"
    popd
    __import_indent=$((__import_indent - 1))
    __import_debug "After dir:    $(pwd)"
}

import_dir() {
    for file in ./${1}/*.ksh; do
        import_script "$file"
    done
}
