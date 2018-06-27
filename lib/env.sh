
#alternative to pushd.sh syntax, ksh-style functions, but not as portable as posix
#append() {
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

#prepend(){
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
    pushvar PATH "$1"
}

path_prepend() {
    prependvar PATH "$1"
}

# http://www.unix.com/shell-programming-and-scripting/137435-ksh-different-syntax-function.html
# function { } style syntax has different features
