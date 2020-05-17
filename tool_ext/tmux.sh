#!/bin/sh
#script to create and connect to shared tmux ala
# # # # # # # # https://unix.stackexchange.com/questions/2523/what-are-other-ways-to-share-a-tmux-session-between-two-users/11065#11065

__TMUX_GROUP=tmux

#must run as root
__setup_shared_tmux(){
  if grep -q "^${__TMUX_GROUP}:" /etc/group
  then
    printf "tmux group already exists\n"
  else
    groupadd $__TMUX_GROUP
  fi
  if [ ! -d "/var/${__TMUX_GROUP}/" ]; then
    mkdir "/var/${__TMUX_GROUP}/"
  fi

  chgrp $__TMUX_GROUP /var/tmux
  chmod g+ws /var/tmux

  printf "shared directory /var/tmux created\n"
  printf "add users to share in group ${__TMUX_GROUP} and use alias shmux\n"
}

alias shmux="tmux -S /var/${__TMUX_GROUP}/shared"
