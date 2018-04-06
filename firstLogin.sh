#!/bin/sh

__LOGIN_TOK=/tmp/.lgin_tkn

show_login_message(){
  printf "welcome... to zombo com\n"
}

if ( ls -ltr $__LOGIN_TOK | grep -q  "$(date '+%b %e')" ); then
  show_login_message
fi
