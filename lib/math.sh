    # number system formatting
    tohex(){
        [[ -z "$1" ]] && {
            printf "Usage: hex <val>\n"
            return 1
        }
        printf "0x%x\n" "$1"
    }

if hash bc 2> /dev/null; then
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

    if hash tput 2> /dev/null; then
        plot(){
            [ -z "$1" ] && {
                printf "usage: plot <xy-func>\n"
                return 1
            }
    
            fn="$1"
            rfn(){
                round $("$fn" "$1")
            }
            
            (( $("$rfn" 1) )) && {
                printf "error: non-numeric function\n"
                return 2
            }
            local fn="$1"

            draw(){
                clear
                local cols=$(tput cols)
                local rows=$(tput lines)
                local cX=$(( cols / 2 ))
                local cY=$(( rows / 2 ))

                # plot fn
                local pcol="$(tput setaf 4)"
                local axcol="$(tput setaf 5)"
                for (( x=0; x<cols; x++)); do

                    # x-axis
                    tput cup $cY $x && printf "${axcol}.${COL_OFF}"

                    # fn
                    tput cup $(( $(rfn $(( x - $cX ))) + cY )) $x &&
                        printf "${pcol}*${COL_OFF}"
                done
    
                # y-axis
                for ((y=0; y<rows; ++y)); do
                    tput cup $y $cX && printf "${axcol}:${COL_OFF}"
                done

                unset x
                unset y
            }

            let loop=1

            exitLoop(){
                loop=0
            }

            trap draw WINCH
            trap exitLoop INT

            draw

            while ((loop)); do
                :
            done

            unset fn
            unset loop

            kill -9 $$  ## TODO: find process leak instead of resorting to this
        }
    fi

    #TODO:
    # - more lambda-like functions, like scale, reduce, map, etc...
    # - graphing-cap goal: https://github.com/kroitor/asciichart
    
    # reference: http://linuxcommand.org/lc3_adv_tput.php
fi

