## filesystem location cheatsheet:


### procfs

procfs is probably the most reliable to use, since it will always be there

| file | description |
| ------------- | ------------- |
| /proc/partitions | lists all block devices and partitions the filesystem recognizes |
| /proc/meminfo | summary of available memory  |
| /proc/devices | current character and block devices whose modules are loaded |
| /proc/diskstats | io statistics of block devices |
| /proc/modules | all loaded modules |
| /proc/interrupts | stores the interrupts that are currently being used |
| /proc/mounts | lists the current mounted file systems |
