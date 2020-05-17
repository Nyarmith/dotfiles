emo(){
    local -Ar emoticons=( ["squareshrug"]='乁( ⁰͡ Ĺ̯ ⁰͡ ) ㄏ '
                          ["happybear"]='ᶘᵒᴥᵒᶅ'
                          ["scream"]='(`Д´)'
                          ["gib"]='༼ つ ◕_◕ ༽つ'
                          ["spell"]='(∩｀-´)⊃━☆ﾟ.*･｡ﾟ'
                          ["sparkle"]='(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧'
                          ["smile"]='(◕‿◕)'
                          ["sunglass"]='(⌐■_■)'
                          ["old"]='( ͡°╭͜ʖ╮͡° )'
                          ["fight"]="(ง︡'-'︠)ง"
                          ["flip"]=' (╯°□°）╯︵ ┻━┻'
                          ["catfish"]='(✿◠‿◠)'
                          ["cheeky"]='(¬‿¬)'
                          ["wat"]='(ㆆ_ㆆ)'
                          ["shrug"]='¯\_(ツ)_/¯')
    [ -z $1 ] && {
        printf "Usage: emo <key>\n  for a list of keys, run emo list\n"
        return 1
    }
    [ "$1" == "list" ] && {
        for i in "${!emoticons[@]}"
        do
            printf "%s : %s\n" "$i" "${emoticons[$i]}"
        done
        return 0
    }
    [ ${emoticons["$1"]+abc} ] || {
        printf "No such key: $1\n"
        return 1
    }
    printf "%s\n" "${emoticons["$1"]}"
}
