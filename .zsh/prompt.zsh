# Prompt Setting
# a;b;c(m%)
# a(48=bg, 38=fg) b(static) c(colornum)
# 148m = green

# NOTE-> Prompt color can found at: .zsh/color.zsh

if [[ "$PSCOLOR" != "" ]]; then
    export baseColor=$(echo \$$PSCOLOR)
else
    case "$($HOME/.zsh/check-os.zsh checkos)" in 
        macos)
        export baseColor=$WhiteBase
        ;;
    esac

    case "$($HOME/.zsh/check-os.zsh checkdist)" in 
        centos) ## BLUE
        export baseColor=$BlueBase
        ;;
        ubuntu) ## ORANGE
        export baseColor=$OrangeBase
        ;;
        debian) ## RED
        export baseColor=$RedBase
        ;;
    esac
fi

# Git/VCS Prompt(-> .zsh/vcs.zsh)
VCSPROMPT=${Gray1}$'${vcs_info_msg_0_}%{\e[m%}'

USER_HOST="${baseColor} %n@%m "
DIR=${Gray0}$' %~ %{\e[m%}'
USERMODE=${Gray1}$' %# %{\e[m%} '

PROMPT=${USER_HOST}${DIR}${VCSPROMPT}$'\n'${USERMODE}
SPROMPT="%{$fg[white]%}%{$suggest%}(✿>╹‸╹%)? < にゃえ？もしかして %B%r%b %{$fg[white]%}のことかな? [そう!(y), 違う!(n),a,e]:${reset_color} "
