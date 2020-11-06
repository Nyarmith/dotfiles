## Bash Pomodoro Timer
## Use named pipe for ipc & persistence w/ self

export SFXDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/timer_sfx"

export FIFO="/tmp/pomodoro"

# fifo is one line with format: $PID timeset timeleft

__countdown()
{
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

    echo "$BASHPID $otime $time" > $FIFO
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
    play $ALARM &> /dev/null
}

pomo()
{
    local usage_str="usage: pomo [-t <number-of-minutes>] [-d --delete] [-p --pause] [-c --continue] [-r --restart]"
    [ ! -f "$FIFO" ] && touch "$FIFO"

    case "$1" in
        -t|--time)
            shift
            local mins="$1"
            if [ -z $mins ]; then
                echo "minutes input required!"
            fi

            # check for existing pid
            local oldpid=$(tail -n1 $FIFO | awk '{print $1;}')
            if [ ! -z $oldpid ] && ((oldpid != -1)); then
                kill $oldpid
            fi
            (nohup bash -c "__countdown $mins" &> /dev/null &)
            ;;
        -d|--delete)
            local oldpid=$(tail -n1 $FIFO | awk '{print $1;}')
            if [ ! -z $oldpid ] && ((oldpid != -1)); then
                kill $oldpid
            fi
            ;;
        -p|--pause)
            local oldpid=$(tail -n1 $FIFO | awk '{print $1;}')
            if [ ! -z $oldpid ] && ((oldpid != -1)); then
                kill $oldpid
            fi
            ;;
        -c|--continue)
            local lastTime=$(tail -n1 $FIFO | awk '{print $3;}')
            [ -z lastTime ] && exit 0
            (nohup bash -c "__countdown $((lastTime / 60))" &> /dev/null &)
            ;;
        -r|--restart)
            local oldpid=$(tail -n1 $FIFO | awk '{print $1;}')
            if [ ! -z $oldpid ] && ((oldpid != -1)); then
                kill $oldpid
            fi
            local lastTime=$(tail -n1 $FIFO | awk '{print $2;}')
            [ -z lastTime ] && exit 0
            (nohup bash -c "__countdown $((lastTime / 60))" &> /dev/null &)
            ;;
    esac
}

export -f pomo
export -f __countdown
