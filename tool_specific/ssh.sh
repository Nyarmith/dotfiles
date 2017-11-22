# Remotely run a command with optional wait-time
function remote_run() {
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
