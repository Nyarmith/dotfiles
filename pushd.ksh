# pushd, popd
# Relocatable, no imports.
# substitute for bash built-ins
test ! -z "$DEBUG" && echo './pushd.ksh'
__delimeter=':'
# Args:
#   var - the environment variable to push onto
#   val - the value to push
__push() {
    eval "export $1=\$$1\${$1:+$__delimeter}$2"
}

# Args:
#   var - the environment variable to pop the value from
__pop() {
    eval "__pop_test=\${$1%$__delimeter*}"
    eval "__var_val=\$$1"
    if test "$__pop_test" = "$__var_val"; then
        eval "export $1="
    else
        eval "export $1=$__pop_test"
    fi
}

# Args:
#   var - the environment variable to peek at
__peek() {
    eval "__peek_val=\${$1##*$__delimeter}"
    echo "$__peek_val"
}

pushd() {
    __push __DIR_STACK "$PWD"
    cd "$1"
}

popd() {
    if test -z "$__DIR_STACK"; then
        echo "popd: directory stack empty"
        return 1
    fi
    cd "$(__peek __DIR_STACK)"
    __pop __DIR_STACK
}
