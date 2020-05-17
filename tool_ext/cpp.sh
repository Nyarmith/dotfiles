symbolsearch(){
    [ -z "$2" ] && {
        printf "usage: symbolsearch <symbol> <path_to_libs_dir>\n"
        return 1
    }
    for lib in $(find base_path -name "${2}/*.a") ; do echo $lib ; nm $lib | grep -i "$1" | grep -v " U "   ; done
}

# TODO: add readelf stuff and objdump parsing
# scanelf, etc...
