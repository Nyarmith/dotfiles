# pushd, popd
# Relocatable, no imports.
# substitute for bash built-ins
test ! -z "$DEBUG" && echo './pushd.sh'

__delimeter=':'

# ==== This section defines common env string manipulations used throughout the dotfiles ====

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
pushvar() {
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

prependvar() {
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

# Args:
#   var - the environment variable to pop the value from
popvar() {
    eval "__pop_test=\${$1%$__delimeter*}"
    eval "__var_val=\$$1"
    if test "$__pop_test" = "$__var_val"; then
        eval "export $1="
    else
        eval "export $1=$__pop_test"
    fi
}

## Args:
##   var - the environment variable to push onto
##   val - the value to push
#pushvar() {
#    eval "export $1=\$$1\${$1:+$__delimeter}$2"
#}
#
## Args:
##   var - the environment variable to insert a value to
#popvar() {
#    eval "__pop_test=\${$1%$__delimeter*}"
#    eval "__var_val=\$$1"
#    if test "$__pop_test" = "$__var_val"; then
#        eval "export $1="
#    else
#        eval "export $1=$__pop_test"
#    fi
#}

# Args:
#   var - the environment variable to peek at
peekvar() {
    eval "__peek_val=\${$1##*$__delimeter}"
    echo "$__peek_val"
}

pushd() {
    pushvar __DIR_STACK "$PWD"
    cd "$1"
}

popd() {
    if test -z "$__DIR_STACK"; then
        echo "popd: directory stack empty"
        return 1
    fi
    cd "$(peekvar __DIR_STACK)"
    popvar __DIR_STACK
}
