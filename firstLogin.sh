#!/bin/sh

#I've been using -z wrong:
#http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html

__LOGIN_TOK=/tmp/.lgin_tkn

show_login_message(){
  #TODO: make this nicer/more extravagant/maybe randomized
  #printf "Welcome back!\n"
cat <<-END
     __          __  _                            ____             _      _ 
     \ \        / / | |                          |  _ \           | |    | |
      \ \  /\  / /__| | ___ ___  _ __ ___   ___  | |_) | __ _  ___| | __ | |
       \ \/  \/ / _ \ |/ __/ _ \| '_ \` _ \ / _ \ |  _ < / _\` |/ __| |/ / | |
        \  /\  /  __/ | (_| (_) | | | | | |  __/ | |_) | (_| | (__|   <  |_|
         \/  \/ \___|_|\___\___/|_| |_| |_|\___| |____/ \__,_|\___|_|\_\ (_)  (*^_^*)
END
}

show_import_messages(){
  if [ ! -z  "${__import_log_var}" ]; then
    printf "\n"
    printf "$__import_log_var"
    sleep 2
    clear
  fi
}

update_tkn(){
  touch $__LOGIN_TOK
}

if [ ! -e $__LOGIN_TOK ]; then
  show_import_messages
  show_login_message
  update_tkn
fi

if  ls -lt $__LOGIN_TOK | grep -q  "$(date '+%b %e')" ; then
  :
else
  sleep 1
  update_tkn
fi
