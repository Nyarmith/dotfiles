if hash bc; then
    # bc aliases
    sin(){
        [[ -z "$1" ]] && {
            printf "Usage: sin <val>\n"
            return 1
        }
        printf "s(%s)\n" "$1" | bc -l
    }

    cos(){
        [[ -z "$1" ]] && {
            printf "Usage: cos <val>\n"
            return 1
        }
        printf "c(%s)\n" "$1" | bc -l
    }

    arctan(){
        [[ -z "$1" ]] && {
            printf "Usage: arctan <val>\n"
            return 1
        }
        printf "a(%s)\n" "$1" | bc -l
    }

    exp(){
        [[ -z "$1" ]] && {
            printf "Usage: exp <val>\n"
            return 1
        }
        printf "e(%s)\n" "$1" | bc -l
    }

    sqrt(){
        [[ -z "$1" ]] && {
            printf "Usage: sqrt <val>\n"
            return 1
        }
        printf "sqrt(%s)\n" "$1" | bc -l
    }

    floor(){
        [[ -z "$1" ]] && {
            printf "Usage: floor <val>\n"
            return 1
        }
        printf "($1)/1\n" | bc
    }
    
    round(){
        [[ -z "$1" ]] && {
            printf "Usage: round <val>\n"
            return 1
        }
        printf "($1+0.5)/1\n" | bc
    }
    
    ceil(){
        [[ -z "$1" ]] && {
            printf "Usage: ceil <val>\n"
            return 1
        }
        printf "($1)/1\n" | bc
    }
fi

