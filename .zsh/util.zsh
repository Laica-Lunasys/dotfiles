#!/bin/zsh

finddups() {
    if [ "$1" = "" ]; then
        echo "Usage: finddups <fileName>"
        return
    fi

    fname=$1
    if [ ! -e "$fname" ]; then
        echo "file not found: $fname"
        return
    fi

    # get hash
    orig_hash=$(cat ./$fname | sha256sum)

    IFS=$'\n'
    for f in $(find . -mindepth 1 -maxdepth 1 -type f); do
        file_hash=$(cat ./$f | sha256sum)
        if [ "$f" != "$fname" ] && [ "$orig_hash" = "$file_hash" ]; then
            echo "$f"
        fi
    done
}

mvdups() {
    IFS=$'\n'
    for x in $(find . -mindepth 1 -maxdepth 1 | grep '([0-9])'); do
        mkdir -p ./_DUPS
        orig=$(echo $x | sed -re "s/\ \([0-9]\)\././g")
        if [ ! -e "$orig" ]; then
            if [ "$1" = "-m" ]; then
                echo "MOVE: $x - does not exists original file. moving... ($x -> $orig)"
                mv $x $orig
            else
                echo "WARN: $x - does not exists original file. skipped. ($orig)"
            fi
        else
            mv -v $x ./_DUPS
        fi
    done
}

mvmov() {
    IFS=$'\n' && for v in $(find . -maxdepth 1 -type f -iname '*.mp4' -o -type f -iname '*.flv' -o -type f -iname '*.webm'); do mkdir -p ./_MOV && mv -v $v ./_MOV; done
}

mvimg() {
    IFS=$'\n' && for v in $(find . -maxdepth 1 -type f -iname '*.png' -o -type f -iname '*.jpg' -o -type f -iname '*.jpeg' -o -type f -iname '*.gif' -o -type f -iname '*.bmp'); do mkdir -p ./_IMG && mv -v $v ./_IMG; done
}

mvmp3() {
    IFS=$'\n' && for v in $(find . -maxdepth 1 -type f -iname '*.mp3'); do mkdir -p ./_MP3 && mv -v $v ./_MP3; done
}

mvzip() {
    IFS=$'\n' && for v in $(find . -maxdepth 1 -type f -iname '*.zip'); do mkdir -p ./_ZIP && mv -v $v ./_ZIP; done
}

sortcpy() {
    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%H' | grep -v / | tail -n +2 | sort -k 6,7 | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do mkdir -p ./_SORTED && echo ":: Writing $v" ; cat $v > ./_SORTED/$v ; done
}

sortcpysimple() {
    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%H' | grep -v / | tail -n +2 | sort -k 7 | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do mkdir -p ./_SORTED && echo ":: Writing $v" ; cat $v > ./_SORTED/$v ; done
}

sortcpytime() {
    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%s' | grep -v / | tail -n +2 | sort -k 6,7 | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do mkdir -p ./_SORTED && echo ":: Writing $v" ; cat $v > ./_SORTED/$v ; done
}


mp4tomp3() {
    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%s' | grep ".mp4"| grep -v / | sort -k 6,7 | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do echo ":: Writing $v" ; ffmpeg -y -i $v -ab 320k $(echo $v | sed -e 's/.mp4//g').mp3; done
}

# mp4tomp3() {
#    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%s' | grep ".mp4"| grep -v / | tail -n +2 | sort -k 6,7 | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do echo ":: Writing $v" ; ffmpeg -y -i $v -ab 320k $(echo $v | sed -e 's/.mp4//g').mp3; done
# }

