# Prompt Setting
# a;b;c(m%)
# a(48=bg, 38=fg) b(static) c(colornum)
# 148m = green

_bg_wht0=$'%{\e[48;5;255m%}'
_fg_wht0=$'%{\e[38;5;255m%}'

_bg_wht1=$'%{\e[48;5;253m%}'
_fg_wht1=$'%{\e[38;5;253m%}'

_bg_wht2=$'%{\e[48;5;251m%}'
_fg_wht3=$'%{\e[38;5;251m%}'

_bg_blk0=$'%{\e[48;5;235m%}'
_fg_blk0=$'%{\e[38;5;235m%}'

_bg_blk0h=$'%{\e[48;5;237m%}'

_bg_blk1=$'%{\e[48;5;239m%}'
_fg_blk1=$'%{\e[38;5;239m%}'

_bg_blk1h=$'%{\e[48;5;240m%}'

_bg_blk2=$'%{\e[48;5;242m%}'
_fg_blk2=$'%{\e[38;5;242m%}'

_blue_prompt=$'%{\e[38;5;39m%}'
_white_prompt=$'%{\e[38;5;255m%}'

_vcs_format="\$(
if [[ -n \"\${vcs_info_msg_0_}\" ]]; then
    echo \"\${_bg_blk1h} \${_bg_blk2}\${_fg_wht2}  ᔑ \${vcs_info_msg_0_}\${vcs_info_msg_1_} \"
else
    echo ''
fi)"

PROMPT="${_bg_blk0}${_fg_wht0}  %n@%m  ${_bg_blk0h} ${_bg_blk1}${_fg_wht1}  %~  ${_vcs_format}${reset_color}"$'\n'
PROMPT+="${_white_prompt} ❯ "

SPROMPT="%{$fg[white]%}%{$suggest%}(✿>╹‸╹%)? < にゃえ？もしかして %B%r%b %{$fg[white]%}のことかな? [そう!(y), 違う!(n),a,e]:${reset_color} "
