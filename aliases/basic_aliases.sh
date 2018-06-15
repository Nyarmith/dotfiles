if [[ $(get_arch) != "HP-UX" && $(get_arch) != "AIX" ]]; then
  alias ls="ls --color"
fi

alias l=ls
alias la='ls -a'
alias ll='ls -lrth'

alias  ..='cd ..'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'

# *WARNING* NOT ACTUALLY AN ALIAS
cdp(){
  cd ~/Projects
  if [ ! -z $1 ]; then
    cd $1
  fi
}
alias cdi="cd ~/Images"
alias cda="cd ~/Audio"
alias cdd="cd ~/Documents"

alias egrep='egrep --color=auto'

alias python=python3

alias t=tmux

alias g++="g++ -std=c++14"
alias dg++="g++ -g -Wall -Wextra -pedantic -std=c++14 -O2 -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wlogical-op -Wcast-qual -Wcast-align -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fstack-protector"
