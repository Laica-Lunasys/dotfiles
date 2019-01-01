# Prompt Setting
# a;b;c(m%)
# a(48=bg, 38=fg) b(static) c(colornum)
# 148m = green

# NOTE-> Prompt color can found at: .zsh/color.zsh

if [[ "$PSCOLOR" != "" ]]; then
    export baseColor=$PSCOLOR
else
    case "$($HOME/.misc/get-osdist.sh | sed -n 1P)" in
        macos)
        export baseColor=$WhiteBase
        ;;
    esac

    case "$($HOME/.misc/get-osdist.sh | sed -n 2P)" in
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

PROMPT=""
RESET=$reset_color

# user@hostname
PROMPT+=$'%{\e[38;5;255;48;5;236m%}  %n@%m  '$'%{\e[38;5;236m%}'
#%{\e[38;5;255m%}

# directory
PROMPT+=$'%{\e[48;5;39m%}'"▍"$'%{\e[38;5;0m%}  %~  '$'%{\e[38;5;39m%}'

PROMPT+="\$(
if [[ -n \"\${vcs_info_msg_0_}\" ]]; then
    echo $'%{\e[48;5;148m%}'"▍"\"%{\e[38;5;0m%} ⤭  \${vcs_info_msg_0_}\${vcs_info_msg_1_} \"$'%{\e[m\e[38;5;148m%}'
  else
    echo $'%{\e[m%}%{\e[38;5;39m%}'
fi)"

PROMPT+="${reset_color}"
# PROMPT+=$'%{\e[48;5;148m%}'"▍"
# PROMPT+=$'%{\e[38;5;0m%}${vcs_info_msg_0_}${vcs_info_msg_1_}%}'
# PROMPT+=$'%{\e[m\e[38;5;148m%}'"▍"

# https://unicode-table.com/en/#25E2
PROMPT+=$'\n'
PROMPT+=$'%{\e[m%}%{\e[38;5;255m%}'" ❯ "$'%{\e[m%} '

SPROMPT="%{$fg[white]%}%{$suggest%}(✿>╹‸╹%)? < にゃえ？もしかして %B%r%b %{$fg[white]%}のことかな? [そう!(y), 違う!(n),a,e]:${reset_color} "
