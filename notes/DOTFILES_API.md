Description of the core api you should expect to be furnished with by these dotfiles

Keep in mind all sh "values" are strings.

### String Manipulation Shortcuts
| function | description |
| ------------- | ------------- |
| pushv | treat variable as a stack, pushing another value onto the top |
| insertv | treat variable as a stack, inserting another value into the front |
| popv | pop the last pushed value from a variable |
| popfv | adds a value at the bottom of a variable's stack |
| pappend | shortcut for adding a directory to your path |
| addlib libdir | add the given path to the systems's equivalent of LD\_LIBRARY\_PATH |

### Diagnostics
| function | description |
| ------------- | ------------- |
| whatos | returns the current os/architecture |
| cores  | returns number of cores on the machine |
