# See if a string contains another.
# Args:
#   (str) target
#   (str) query
str_contains() {
    echo "$1" | grep "$2" > /dev/null
    return $?
}

# See if a string starts with another.
# Args:
#   (str) target - the string to search within
#   (str) query
str_startswith() {
    test -z "${1##$2*}"
    return $?
}

# Join a set of arguments together.
# Args:
#   (str) joiner
#   (str...) parts
str_join() {
    __str_join__delimeter="$1"
    __str_join__val="$2"
    shift
    shift
    for __str_join__item in "$@"; do
        __str_join__val="$__str_join__val$__str_join__delimeter$__str_join__item"
    done
    echo "$__str_join__val"
}

