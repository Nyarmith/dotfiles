# Remotely run a command with optional wait-time
remote_run() {
    ADR=$1
    CMD=$2
    if [[ -z $3 ]]; then
        DELAY=$3
    else
        DELAY=2
    fi
    ssh -T $ADR "$CMD" &
    sleep $DELAY
}

ssh_tunnel(){
    if [[ -z $4 ]]; then
      printf "ssh_tunnel <local_port> <proxy_machine> <tun_machine:port>\n"
    fi
    ssh -L $2:$4 $3
}
