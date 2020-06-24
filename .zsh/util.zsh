#!/bin/zsh

findsame() {
    if [ "$1" = "" ]; then
        echo "Usage: findsame <fileName>"
        return
    fi

    fname=$1
    if [ ! -e "$fname" ]; then
        echo "file not found: $fname"
        return
    fi

    # get hash
    orig_hash=$(cat ./$fname | md5sum)

    IFS=$'\n'
    for f in $(find . -mindepth 1 -maxdepth 1 -type f); do
        file_hash=$(cat ./$f | md5sum)
        if [ "$f" != "$fname" ] && [ "$orig_hash" = "$file_hash" ]; then
            echo "$f"
        fi
    done
}

finddups() {
    # get hash
    declare -A _dups_hash

    fileLen="$(find . -mindepth 1 -maxdepth 1 -type f | wc -l)"

    cnt=0
    IFS=$'\n'
    for f in $(find . -mindepth 1 -maxdepth 1 -type f); do
        cnt=$(expr $cnt + 1)
        echo "$cnt/$fileLen\t$f"
        file_hash=$(cat $f | md5sum | tr -d ' -')
        if [ "$_dups_hash[$file_hash]" = "" ]; then
            _dups_hash[$file_hash]="$f"
        else
            _dups_hash[$file_hash]="$_dups_hash[$file_hash]\\$f"
        fi
    done

    unset IFS
    for k in $(echo ${(k)_dups_hash[@]}); do
        if [ "$(echo $_dups_hash[$k] | grep '\\')" ]; then
            echo ""
            echo "$k:"
            IFS=$'\\'
            for f in $(echo $_dups_hash[$k]); do
                echo "$f"
            done
            unset IFS
        fi
    done
}

mvsame() {
    # get hash
    declare -A _dups_hash

    fileLen="$(find . -mindepth 1 -maxdepth 1 -type f | wc -l)"

    cnt=0
    IFS=$'\n'
    for f in $(find . -mindepth 1 -maxdepth 1 -type f); do
        cnt=$(expr $cnt + 1)
        echo "$cnt/$fileLen\t$f"
        file_hash=$(cat $f | md5sum | tr -d ' -')
        if [ "$_dups_hash[$file_hash]" = "" ]; then
            _dups_hash[$file_hash]="$f"
        else
            _dups_hash[$file_hash]="$_dups_hash[$file_hash]\\$f"
        fi
    done

    unset IFS
    for k in $(echo ${(k)_dups_hash[@]}); do
        if [ "$(echo $_dups_hash[$k] | grep '\\')" ]; then
            echo ""
            echo "$k:"
            mkdir -p $PWD/_SAME/$k

            IFS=$'\\'
            for f in $(echo $_dups_hash[$k]); do
                echo "$f"
                mv $f $PWD/_SAME/$k/
            done
            unset IFS
        fi
    done
}




mvdups() {
    IFS=$'\n'
    for x in $(find . -mindepth 1 -maxdepth 1 | grep '([0-9])'); do
        mkdir -p ./_DUPS
        orig=$(echo $x | sed -e "s/\ \([0-9]\)\././g")
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
    IFS=$'\n' && for v in $(find . -maxdepth 1 -type f -iname '*.mp4' -o -type f -iname '*.flv' -o -type f -iname '*.webm' -o -type f -iname '*.wmv' -o -type f -iname '*.avi'); do mkdir -p ./_MOV && mv -v $v ./_MOV; done
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
    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%s' | grep -v / | tail -n +2 | sort -k 6,7 | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do mkdir -p ./_SORTED && echo ":: Writing $v" ; cat $v > ./_SORTED/$v ; done
}

sortcpysimple() {
    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%s' | grep -v / | tail -n +2 | sort -nk 7 | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do mkdir -p ./_SORTED && echo ":: Writing $v" ; cat $v > ./_SORTED/$v ; done
}

sortcpytime() {
    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%s' | grep -v / | tail -n +2 | sort -k 6 -k 7n | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do mkdir -p ./_SORTED && echo ":: Writing $v" ; cat $v > ./_SORTED/$v ; done
}

sortcpynum() {
    IFS=$'\n'; for v in $(for f in $(find . -maxdepth 1 -type f); do echo -ne "$(echo $f | sed -e 's/\.\///g') "; ls --color=never -pQl --time-style='+%s' $f; done | sort -t '_' -k 2n -k 1n); do
        _file=$(echo $v | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\.\///g')
        mkdir -p ./_SORTED
        echo ":: Writing $_file"
        cat $_file > ./_SORTED/$_file
    done
}

mp4tomp3() {
    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%s' | grep ".mp4"| grep -v / | sort -k 6,7 | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do echo ":: Writing $v" ; ffmpeg -y -i $v -ab 320k $(echo $v | sed -e 's/.mp4//g').mp3; done
}

trimsound() {
    mkdir -p ./_GEN
    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%s' | grep ".mp4"| grep -v / | sort -k 6,7 | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do
        if [ -e "_GEN/$(echo $v | sed -e 's/\.\///g')" ]; then
            echo "!! Already exists: $v, Skip."
        else
            echo ":: Writing $v"
            ffmpeg -y -i $v -an ./_GEN/$(echo $v | sed -e 's/\.\///g') -vcodec copy
        fi
    done
}


# mp4tomp3() {
#    IFS=$'\n' && for v in $(ls --color=never -p -Q -l --time-style='+%s' | grep ".mp4"| grep -v / | tail -n +2 | sort -k 6,7 | cut -d "\"" -f 2- | sed -e 's/\"$//g' -e 's/\\//g'); do echo ":: Writing $v" ; ffmpeg -y -i $v -ab 320k $(echo $v | sed -e 's/.mp4//g').mp3; done
# }

