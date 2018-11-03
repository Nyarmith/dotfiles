
#if bash exists, we can define these functions
if echo "$SHELL" | grep -q "bash"; then
  bash_curl(){
    if [ -z $1 ]; then
      printf "Usage: bash_curl <URI>\n"
      return 1
    fi
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
else
  printf "* Warning: Your shell isn't bash. Some functions will be unavailable."

fi
