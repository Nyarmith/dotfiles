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

path_append() {
    env_append PATH "$1"
}

path_prepend() {
    env_prepend PATH "$1"
}

