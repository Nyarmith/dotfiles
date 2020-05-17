# Remotely run a command with optional wait-time
function dattach() {
    [ -z "$1" ] && {
        printf "usage: dattach <container>\n"
        return 1
    }
    docker exec -it $1 /bin/bash
}

function drestart() {
    [ -z "$1" ] && {
        printf "usage: drestart <container> [container2] ... \n"
        return 1
    }
    docker restart $@
}

function ddebug() {
    [ -z "$2" ] && {
        printf "usage: ddebug <bad_container> <tool_container>\n"
        return 1
    }
    docker run -it --net=container:$1 --pid=container:$1 $2 /bin/bash 
}
