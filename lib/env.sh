# this lets programs that support the XDF_CONFIG spec find their condig files
export XDG_CONFIG_HOME="$(pwd)/config"

# vim does not support it, so this is a workaround hack
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

