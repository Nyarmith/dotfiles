# Get os for a host

__getlinux(){
    if hash lsb_release 2> /dev/null; then
        joins ' ' $(lsb_release -d -r | awk '{print $2}')
    elif [ -r /proc/version ]; then
        cat /proc/version | awk '{print $3}'
    elif hash uname 2> /dev/null; then
        uname -mrs
    fi
}

# - RHEL, CentOS, HPUX, AIX, SunOS, Linux (some generic heuristics)
whatos(){
    local OS=""
    if test -f /etc/redhat-release; then
        OS=`cat /etc/redhat-release | awk {'print $1'}`
        if test "$OS" = "Red"; then
            OS=RHEL
        else
            OS=CentOS
        fi
    else
        OS=`uname -a | awk {'print $1'}`
        if test "$OS" = "HP-UX"; then
            OS=HPUX
        elif test "$OS" = "AIX"; then
            OS=AIX
        elif test "$OS" = "SunOS"; then
            OS=SunOS
        else
            OS=$(__getlinux)
        fi
    fi
    echo $OS
}

#shared library variable based on platform

if [[ "$(whatos)" =~ "HP-UX" ]]; then
    __shlib_path="SHLIB_PATH"
elif [[ "$(whatos)" =~ "AIX" ]]; then
    __shlib_path="LIBPATH"
else
    __shlib_path="LD_LIBRARY_PATH"
fi

export $__shlib_path

#accept directory, adds to library search path
addlib(){
    pushv $__shlib_path "$1"
}

#get number of cores on machine
cores(){
    if str_contains "$(whatos)" "SunOS"; then
        psrinfo -p
    elif str_contains "$(whatos)" "AIX"; then
        lsconf | grep Process #lsdev -Cc processor
    else   #some linux
        grep -c ^processor /proc/cpuinfo
    fi
}

# no fancy ls available for HP-UX
if [[ $(whatos) == "HP-UX" || $(whatos) == "AIX" ]]; then
  unalias ls
fi
