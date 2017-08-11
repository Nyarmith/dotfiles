# Set environment variable.
# Args:
#   (str) name
#   (str) val
env_set() {
    eval "export $1=\"$2\""
}

env_unset() {
    eval "unset $1"
}

# Get environment variable.
env_get() {
    eval "echo \$$1"
}

# Args:
#   (str) var - the environment variable to append to
#   (str) val - the value to append
env_append() {
    __env_append__var=$1
    __env_append__value="$(env_get $__env_append__var)"
    if test -z "$__env_append__value"; then
        env_set $__env_append__var "$2"
    elif str_contains "$__env_append__value" "$2"; then
        :
    else
        env_set $__env_append__var "$__env_append__value:$2"
    fi
}


env_prepend() {
    __env_prepend__var="$1"
    __env_prepend__value="$(env_get $__env_prepend__var)"
    if test -z "$__env_prepend__value"; then
        env_set $__env_prepend__var "$2"
    elif str_contains "$__env_prepend__value" "$2"; then
        :
    else
        env_set $__env_prepend__var "$2:$__env_prepend__value"
    fi
}



#alternate versions using ksh-style functions instead of posix-style ones
#function append {
#    typeset -n var="$1"
#    if [[ -z $var ]]; then
#        export var="$2"
#    else
#        echo "$var" | grep $2 > /dev/null
#        if [[ $? != 0 ]]; then
#            export var="$var:$2"
#        fi
#    fi
#}
#function prepend{
#    typeset -n var="$1"
#    if [[ -z $var ]]; then
#        export var="$2"
#    else
#        echo "$var" | grep $2 > /dev/null
#        if [[ $? != 0 ]]; then
#            export var="$2:$var"
#        fi
#    fi
#}


path_append() {
    append PATH "$1"
}

path_prepend() {
    prepend PATH "$1"
}

# http://www.unix.com/shell-programming-and-scripting/137435-ksh-different-syntax-function.html
# function { } style syntax has different features
