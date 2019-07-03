# Remotely run a command with optional wait-time
function attach_to() {
    $1
    docker exec -it $1 /bin/bash
}

function attach_debug() {
    $1
    $2
    docker run -it --net=container:$1 --pid=container:$1 $2 /bin/bash 
}
