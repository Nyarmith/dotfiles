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
