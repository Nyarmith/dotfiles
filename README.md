## Portable bash dotfiles (formerly SH (formerly KSH))
This directory is meant to be a standalone set of bash functions and aliases for bash versions 4.4 and up. The sh directory can be located anywhere (e.g. some random network drive) , all you need to do is change to the base directory and source init.sh to populate your current session.

### Usage

add a line in your bashrc to source the init script

```
source /path/to/dir/init.sh
```

If you want tmux to always be running with a new bash session, set `TMUX_ALWAYS_ON=1` before sourcing `init.sh`

### Organization
```
.
├── lib             # common functions and env vars
├── prompt_string   # PS1 configuration
├── aliases         # general tool-independent aliases
├── tool_ext        # bash functions aimed at extending cmdline tools
├── os_specific     # dotfiles that do things based on what OS you're on
├── host_specific   # host-specific additions, ignored by git
├── config          # config files for programs, found via XDG\_CONFIG\_HOME
└── notes           # miscellaneous notes on sysadmin utilities and cmdline stuff
```


### Adding Dotfiles

From the start to end of the sourcing process in init.sh, the function `printlog` is available for any submodule to print debug output. Debug info will be printed if the var `DOTDEBUG` exists and is non-zero. Thus for a test run, you could do something like `DOTDEBUG=1 && source /path/to/dir/init.sh`

### Customizing your repo

You, dear reader, can view this as a base for your own dotfiles. The directory-based structure is pretty general, but I suggest you remove everything you don't need or want to understand. Err on the side of throwing something away if unsure. A minimal set to grow from might just include the `lib`, `aliases` and `config` directories.

<br />

--------

<br />

TODO:
* More bash networking trix
* Randomized Login Messages
  * Randomized Login Ascii Art
* More bash file descriptor trix
* Integrate this with some stupid webapi (for linux webapp?)
* QOL stuff like 2-line PS1, more colors, ncurses screensavers
* More c++ utilities
* More bash job & pid management trix
* Pushdown-automata
* Ncurses forms and stupid widgets (e.g. session-based sticky-notes)
* An interpreter purely in bash
