## utilities cheatsheet:

| command | description |
| ------------- | ------------- |
| typeset -f | List functions defined in environment, and their definitions |
| typeset -F | Same as above, but only function names |
| declare | same as above two, but apparently newer |
| free | simple command to show free ram and swap -mto option for mb units, totals shown and hiding bufferinfo |
| lsof | ls open files, including network connections + devices. Useful options: -u \<user\>, -i@\<ip\> for a particular ip, or just giving a filename |
| nice/renice | change priority/"niceness". I've only had to use these like twice |

Finally, mneumonic: du = "disk usage? [of a file]" like a query of a folder or something, df = "disk free [of mounted filesystem]". An Imperative statement. I always confuse the two.

### String Manipulation

Finding, manipulating strings with built-ins and utilities

| problem | solution |
| ------------- | ------------- |
| Does my variable contain a substring? | echo $VAR \| grep -q "string", in this case grep returns 0 if there's a match, otherwise a 1 |
| Does a file contain a substring? | grep -qE '^regex_*pattern' file, same as above pretty much |
| I want to find a folder that maybe has the string "coolproj" in it  | find . -type d -iname "\*coolproj\*" |
| I want to print out the nth column of some input | cat input.txt \| awk '{print $2}' |
| but the first few lines doesn't conform to the format| sed -e 4d input.txt \| \<above_cmd\>, tail -n +4 input.txt \| \<above_cmd\> |
| get last line of file| tail -n1 \<file\> |
| I meant last n=3 lines | tail -n3 \<file\> |
| I want to find a line, then remove a word from that specific line in a file | lnum=$(grep -n \<pattern\> \<file\> \| cut -d : -f1 \| head -n1); sed -i "$lnum/\<pattern\>/\<new_pattern\>/" \<file\> |
| I want to replace the n=112th line in a file | sed -i "112s/.*/\<new_line\>/" \<file\> |
| Actually, I really meant to delete that line entirely | sed -i "112d" \<file\> |
| Now I want to delete all lines with that pattern entirely | sed -i "/\<pattern\>/d" \<file\> |
| List all files in current dir containing a string | grep -rl \<pattern\>  \| uniq|
| Maybe I want to search only .txt and .pl files | grep -rl -i --include \\\*.txt --include \\\*.pl "\<pattern\>" ./ \| uniq |
| ok but I actually just want to do that only on all .txt files | find . -iname "*.txt" -execdir grep -l \<pattern\>  |
| and I want to rename them to .md files!! | find . -iname "*.txt" -exec rename 's/.txt$/.md/' {} \\;|
| wow you're good! | thank you |

### Debugging Tools
You will inevitably have to figure out why a binary/command/process isn't working. Here's how.

| problem | solution |
| ------------- | ------------- |
| I would like to see all the syscalls my binary is doing | strace -f -o file.log my_command |
| Buddy, I'm on AIX/SunOS | truss -f -o out.log my_command  |
| Weirdly enough I'm debugging on HP-UX | tusc -f -o /full/path/to/out.log my_command  |

#### Some Common Platform Differences

| RHEL (v7.2) | SunOS (v11.3) | AIX (v7.2) | HP-UX (v11.31) |
| ------------- | ------------- | ------------- | ------------- |
| grep -ri "expr" | find . -type f -print \| grep -i "expr" | grep -ri "expr"  | find . -type f -print \| grep -i "expr" |
| uname -v | uname -v | oslevel -s  | uname -r |
| swapon | swap | lsps | swapinfo |
| /etc/fstab | /etc/vfstab | /etc/file systems | /etc/fstab |
| rpm -qa | pkg{info,chk} | ls{lpp,src} | swlist |
| rpm -i | pkgadd | smit install | swinstall |
| dmesg | prtdiag | errpt | dmesg |
| sysctl | prtctl + /etc/system | vmo, ioo, no, schedo, nfso, chdev | kctune |
| systemctl | Svcadm, svcs  | lssrc, stopsrc, startsrc | /etc/init.d/net start |
| modprobe | drvconfig | cfgmgr | insf |
| lvresize | growfs | chfs | extendfs |
| iptables | ipf, ipfconfig | \*filt | ipf, ipfconfig |
| ls{pci,dev,usb,blk} | ptrconf | ls{cfg,attr}, prtconf | ioscan, dmesg |
| ext4 | ufs, zfs | jfs, jfs2 | hfs, VxFS |

<!-- Bash-specific string manipulation, where variable $str will hold our string
| problem | solution |
| ------------- | ------------- |
| I want to change the extension from .txt to .md | ${str:} |
| I want to change the extension from .txt to .md | | >
-->

<!-- section about where the core-essential logs are -->
