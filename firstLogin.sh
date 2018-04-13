#!/bin/sh

#I've been using -z wrong:
#http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html

__LOGIN_TOK=/tmp/.lgin_tkn

show_login_message(){
  #TODO: make this nicer/more extravagant/maybe randomized
  printf "Welcome back!\n"
}

update_tkn(){
  touch $__LOGIN_TOK
}

if [ ! -e $__LOGIN_TOK ]; then
  show_login_message
  update_tkn
fi

if  ls -lt $__LOGIN_TOK | grep -q  "$(date '+%b %e')" ; then
  :
else
  show_login_message
  update_tkn
fi
