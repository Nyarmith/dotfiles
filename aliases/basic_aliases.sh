alias ls="ls --color=auto"
alias l=ls
alias la='ls -a'
alias ll='ls -lrth'

alias  ..='cd ..'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'

alias cdi="cd ~/Images"
alias cda="cd ~/Audio"
alias cdd="cd ~/Documents"

alias egrep='egrep --color=auto'

#maybe workaround for tmux not supporting xdg_config_home
#alias tmux="$XDG_CONFIG_HOME/tmux/tmux.conf"
alias tmux='tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf'
alias t=tmux

alias g++="g++ -std=c++14"
alias dg++="g++ -g -Wall -Wextra -pedantic -std=c++14 -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wlogical-op -Wcast-qual -Wcast-align -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fstack-protector"
