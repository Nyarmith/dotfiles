sshrun() {
    ADR=$1
    CMD=$2
    ssh -T $ADR "$CMD" &
}

sshtun(){
    if [[ -z $4 ]]; then
      printf "ssh_tunnel <local_port> <proxy_machine> <tun_machine:port>\n"
    fi
    ssh -L $2:$4 $3
}

alias sshit='ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no"'
