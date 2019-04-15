#!/bin/zsh

mvdups() {
    IFS=$'\n' && for x in $(find . -mindepth 1 -maxdepth 1 | grep '([0-9])'); do mkdir -p ./_DUPS && mv -v $x ./_DUPS; done
}

mvmov() {
    IFS=$'\n' && for v in $(find . -maxdepth 1 -type f -iname '*.mp4' -o -type f -iname '*.flv'); do mkdir -p ./_MOV && mv -v $v ./_MOV; done
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

mp4tomp3() {
    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%s' | grep ".mp4"| grep -v / | sort -k 6,7 | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do echo ":: Writing $v" ; ffmpeg -y -i $v -ab 320k $(echo $v | sed -e 's/.mp4//g').mp3; done
}

# mp4tomp3() {
#    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%s' | grep ".mp4"| grep -v / | tail -n +2 | sort -k 6,7 | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do echo ":: Writing $v" ; ffmpeg -y -i $v -ab 320k $(echo $v | sed -e 's/.mp4//g').mp3; done
# }

