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
        elif test "$OS" = "SunOS"; then
            arch=SunOS
        else
            arch=$OS    #usually "Linux"
        fi
    fi
    echo $arch
}

export ARCH="$(get_arch)"
