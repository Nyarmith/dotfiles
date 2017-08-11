# Get arch for a host
# - RHEL, CentOS, HPUX, AIX, SunOS, Linux (generic)
get_arch() {
    typeset arch=""
    if test -f /etc/redhat-release; then
        OS=`cat /etc/redhat-release | awk {'print $1'}`
        if test "$OS" = "Red"; then
            arch=RHEL
        else
            arch=CentOS
        fi
    else
        OS=`uname -a | awk {'print $1'}`
        if test "$OS" = "HP-UX"; then
            arch=HPUX
        elif test "$OS" = "AIX"; then
            arch=AIX
        elif test "$OS" = "SunOS"; then
            arch=SunOS
        else
            arch=$OS    #usually "Linux"
        fi
    fi
    echo $arch
}

ARCH="$(get_arch)"
export ARCH


#shared library variable based on platform

if str_contains "$(get_arch)" "HP-UX"; then
    __shlib_path="SHLIB_PATH"
elif str_contains "$(get_arch)" "AIX"; then
    __shlib_path="LIBPATH"
else
    __shlib_path="LD_LIBRARY_PATH"
fi

export $__shlib_path #may not be necessary

#accept directory, adds to library search path
addlibs(){
    env_prepend $__shlib_path $1
}

