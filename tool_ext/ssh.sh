sshrun() {
    ADR=$1
    CMD=$2
    ssh -T $ADR "$CMD" &
}

sshtun(){
    if [[ -z $3 ]]; then
      printf "ssh_tunnel <local_port> <proxy_machine> <tun_machine:port>\n"
      return 1
    fi
    ssh -L $1:$3 $2
}

alias sshit='ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no"'
alias scpit='scp -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no"'
