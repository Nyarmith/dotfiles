Man, the original version of this got unjustly wiped some time ago and I was pissed


## Networking Cheatsheet:

| problem | solution |
| ------------- | ------------- |
| How do I see if a | |
| | |

## Fundamental Network Tools

These seem to be on all platforms despite not being in the POSIX standard

| binary | description |
| ------------- | ------------- |
| route | get or set routes |
| nslookup | look up a dns record and get some info |
| telnet | uses: see if a port is listening |
| ruptime |  |
| rwho |  |
| traceroute |  |
| ftp | file transfer, need to not forget it exists when scp is unavailable |
| rlogin | proto-ssh, this is pretty much just here so I don't forget about it |




#### Platform Networking Differences

| RHEL (v7.2) | SunOS (v11.3) | AIX (v7.2) | HP-UX (v11.31) |
| ------------- | ------------- | ------------- | ------------- |
| grep -ri "expr" | find . -type f -print \| grep -i "expr" | grep -ri "expr"  | find . -type f -print \| grep -i "expr" |
| uname -v | uname -v | oslevel -s  | uname -r |

References:
http://www.unixguide.net/cgi-bin/unixguide.cgi
https://unix4admins.blogspot.com/2013/03/unix-commands-comparison-sheet.html

