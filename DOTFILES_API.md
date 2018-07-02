Description of the core api you should expect to be furnished with by these dotfiles

Keep in mind all sh "values" are strings.

### String Manipulation Shortcuts
| function | description |
| ------------- | ------------- |
| pushvar envvar | treat variable as a stack, putting another value on it |
| popvar | pop the last pushed value from a variable |
| prependvar | adds a value at the bottom of a variable's stack |
| path_append | shortcut for adding a directory to your path |
| addlibs libdir | add the given path to the current environment's lib-search path in an os-invariant way |
| str_contains arg1 arg2 | return true if arg1 contains the arg2 as a substring |
| str_startswith arg1 arg2 | return true if arg1 starts with arg2 |

### Diagnostics
| function | description |
| ------------- | ------------- |
| get_arch | returns the current os/architecture |
| corenum  | returns number of cores on the machine |
