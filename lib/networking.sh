burl(){
  [[ -z "$1" ]] && {
    printf "Usage: burl <URI>\n"
    return 1
  }

  exec 5<>/dev/tcp/$1/80  #open file descriptor 5 for io on this particular socket
  #exec isn't taking a command, which lets it instead open a file in the current shell
  # e.g. exec 3<> File.txt, opens File.txt and assigned fd 3 to it
  echo -e "GET / HTTP/1.1\r\nhost: ${1}\r\nConnection: close\r\n\r\n" >&5
  cat <&5 #&5 is just a way to specify the file descriptor 5, as opposed to a file whose name is 5

  #additional reference:
  #http://tldp.org/LDP/abs/html/io-redirection.html
  #http://www.linuxjournal.com/content/more-using-bashs-built-devtcp-file-tcpip
}

#fun gimmick
top10(){
  history | awk '{print $2}' | awk 'BEGIN {FS="|"}{print $1}' | sort | uniq -c | sort -nr | head
}

if hash socat 2> /dev/null; do

    servefile(){
        [ -z "$1" ] && {
            printf "usage: servefile <file> [port]\n"
            return 1
        }

        local file="$1"
        local port="${2:-80}"
        local mime_type=$(mimetype "$file")
        local size_bytes=$(du -b "$file" | cut -f1)
        local file_name=$(basename "$file")
        local header="\

        HTTP/1.1 200 OK
        Content-Type: $mime_type
        Content-Disposition: attachment; filename=$file_name
        Content-Length: $size_bytes
        "
        socat -d -d - tcp-l:"$port",reuseaddr,fork < <(printf "$header"; cat "$file")
    }
done

