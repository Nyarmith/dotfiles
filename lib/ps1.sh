# Provides PS1-editing functions.

# Determine shell
# http://stackoverflow.com/questions/3327013/how-to-determine-the-current-shell-im-working-on
__shell_type() {
    if test ! -z "$BASH"; then
        echo "bash"
    else
        echo "ksh"
    fi
}

# see https://docstore.mik.ua/orelly/unix3/upt/ch04_10.htm
case "$(__shell_type)" in
    bash) __ps1_pre_esc="\["; __ps1_post_esc="\]";;
    ksh ) __ps1_pre_esc=" "; __ps1_post_esc=" ";;
    *   ) echo "Shell not recognized"
esac
# For platforms that don't automatically do \r, e.g. old Solaris
__ps1_cr="$(printf "\r")"
# ksh does width formatting with [npr][cr][PS1]
# we insert a newline later to avoid clobbering non-newline-ending text
# from previous commands.
__ps1_ksh_prefix="$__ps1_pre_esc$__ps1_cr"

# When setting PS1 initially, pipe or pass to this before
# setting on PS1.
# Doesn't work on HP-UX, the ksh there does not understand it.
ps1_format() {
    if test -z "$1"; then
        __ps1_esc__text="$(cat)"
    else
        __ps1_esc__text="$1"
    fi
    case "$(__shell_type)" in
        bash) printf "\n$__ps1_esc__text";;
        ksh ) printf "$__ps1_ksh_prefix\n$__ps1_esc__text";;
        *   ) echo "Shell not recognized"
    esac
}

# Set color, escaping non-printing characters.
# If second argument is not passed, reads from stdin.
# This doesn't work to set proper PS1 size on ksh on old Solaris.
# Args:
#   (num) color number
#   (str?) the text to color
ps1_color() {
    __ps1_color__color="$1"
    if test -z "$2"; then
        __ps1_color__text="$(cat)"
    else
        __ps1_color__text="$2"
    fi
    printf "$__ps1_pre_esc\033[${__ps1_color__color}m$__ps1_post_esc$__ps1_color__text$__ps1_pre_esc\033[0m$__ps1_post_esc"
}

# Prepend to PS1, preserving any leading escape characters as needed.
ps1_prepend() {
    __ps1_prepend__text="$1"
    # trim first 2 bytes
    if str_startswith "$PS1" "$__ps1_ksh_prefix"; then
        # cuts off C-a and \r\n
        __ps1_prepend__current="$(echo "$PS1" | sed 1,1d)"
    else
        # cuts off leading \n
        __ps1_prepend__current="$(echo "$PS1" | sed 1,1d)"
    fi
    printf "$__ps1_prepend__text$__ps1_prepend__current" | ps1_format
}

