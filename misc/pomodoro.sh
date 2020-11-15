## Bash Pomodoro Timer
## Use named pipe for ipc & persistence w/ self

export SFXDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/timer_sfx"

export FIFO="/tmp/pomodoro"

# fifo is one line with format: $PID timeset timeleft

__countdown()
{
    local message="none"
    [ ! -z "$2" ] && {
        message="$2"
    }

    local START_SHORT="$SFXDIR/windup_short.wav"
    local START_LONG="$SFXDIR/windup_long.wav"
    local HALFWAY="$SFXDIR/ticking.wav"
    local ALARM="$SFXDIR/ringing.wav"

    local time=$(echo 60*"$1" | bc -l)
    time="${time%.*}"
    local otime="$time"

    local halfpt=$((otime/2))
    local halfHit=0;

    local msdTime="${time%.*}"
    if ((msdTime > 8*60)); then
        play "$START_LONG" &> /dev/null
    else
        play "$START_SHORT" &> /dev/null
    fi

    echo "$BASHPID $otime $time $message" > $FIFO
    while ((time > 0)); do
        if ((time > 15)); then
            sleep 15;
            ((time-=15))
        else
            sleep $time;
            ((time=0))
        fi

        if ((time <= halfpt && halfHit == 0)); then
            ((halfHit = 1))
            play $HALFWAY &> /dev/null
        fi
        echo "$BASHPID $otime $time" > $FIFO
    done
    echo "-1 $otime $time" > $FIFO

    if [ "$message" != "none" ]; then
        notify-send "pomo: $message"
    fi

    play $ALARM &> /dev/null
}

pomo()
{
    local usage_str="usage: pomo [-t <number-of-minutes>] [-d --delete] [-p --pause] [-c --continue] [-r --restart] [-m --message <message>]"
    [ ! -f "$FIFO" ] && touch "$FIFO"

    while (($#)); do
        case "$1" in
            -t|--time)
                shift
                local mins="$1"
                local message="none"
                if [ -z $mins ]; then
                    echo "minutes input required!"
                fi

                # check for existing pid
                local oldpid=$(tail -n1 $FIFO | awk '{print $1;}')
                if [ ! -z $oldpid ] && ((oldpid != -1)); then
                    # todo, check that the pid doesn't have a new process name
                    kill $oldpid 2>&1 | /dev/null
                fi
                local runTime="$mins"
                shift
                ;;
            -d|--delete)
                local oldpid=$(tail -n1 $FIFO | awk '{print $1;}')
                if [ ! -z $oldpid ] && ((oldpid != -1)); then
                    kill $oldpid
                fi
                return 0
                ;;
            -p|--pause)
                local oldpid=$(tail -n1 $FIFO | awk '{print $1;}')
                if [ ! -z $oldpid ] && ((oldpid != -1)); then
                    kill $oldpid
                fi
                return 0
                ;;
            -c|--continue)
                mins=$(tail -n1 $FIFO | awk '{print $3;}')
                [ -z lastTime ] && exit 0
                message=$(tail -n1 $FIFO | cut -d ' ' -f4-)
                mins="$((lastTime / 60))"
                shift
                ;;
            -r|--restart)
                local oldpid=$(tail -n1 $FIFO | awk '{print $1;}')
                if [ ! -z $oldpid ] && ((oldpid != -1)); then
                    kill $oldpid
                fi
                local lastTime=$(tail -n1 $FIFO | awk '{print $2;}')
                [ -z lastTime ] && exit 0
                message=$(tail -n1 $FIFO | cut -d ' ' -f4-)
                mins="$((lastTime / 60))"
                shift
                ;;
            -m|--message)
                shift
                [ -z "$1" ] && {
                    echo "no message supplied"
                    return 1
                }
                message="$1"
                shift
                ;;
        esac
    done

    (nohup bash -c "__countdown $runTime \"$message\"" &> /dev/null &)
}

export -f pomo
export -f __countdown
