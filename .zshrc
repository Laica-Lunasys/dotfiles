## Autoload
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit -C

# Avoid duplicates in path
typeset -U path PATH

#---------------------
# Appearance
#---------------------
# LS_COLOR
source $HOME/.zsh/color.zsh

# Prompt (fallback)
# PS1="[%n@%m %~]%# "

#-------------------------------
# For multiline prompt support
#-------------------------------
# clear command for non-ncurses environment
function clear() {
    if (( $+commands[clear] )) && command clear 2>/dev/null; then
        return
    fi
    echoti clear 2>/dev/null
    print -n -- "\e[H\e[2J\e[3J"
}

function __run_print_next_time() {
    if [ "${__do_not_print_next_time}" = "YES" ]; then
        unset __do_not_print_next_time
    else
        print
    fi
}

# Draw newline before every prompt rendering
# + Don't print newline at first prompt rendering
# (function activation only)
__do_not_print_next_time="YES"
add-zsh-hook precmd __run_print_next_time

# clear console buffers
# + Don't print newline in next prompt rendering
alias clear="__do_not_print_next_time='YES' && clear"

#----------------------
# Keybind
#----------------------
bindkey -e
source $HOME/.zsh/keybinds.zsh

#----------------
# Completion
#----------------
# Option
setopt auto_param_slash
setopt mark_dirs
setopt list_types
setopt auto_menu
setopt auto_param_keys
setopt interactive_comments
setopt magic_equal_subst
setopt share_history

setopt complete_in_word
setopt always_last_prompt

setopt nonomatch

setopt hist_ignore_space

zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:options' description 'yes'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache true

# zstyle ':completion:*:cd:*' ignore-parents parent pwd

#-----------------------
# Misc Settings
#-----------------------
# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

#---------------------
# Import settings
#---------------------
OS="$($HOME/.misc/get-osdist.sh | sed -n 1P)"
PROFILE_DIR="$HOME/.zsh/profile/$OS.zsh"
if [ -e $PROFILE_DIR ]; then
    source $PROFILE_DIR
fi
source $HOME/.zsh/util.zsh
source $HOME/.zsh/omz/title.zsh
source $HOME/.zsh/omz/directory.zsh

if [ ! -z $WSLENV ]; then
    source $HOME/.zsh/wsl.zsh
fi

# fzf: Optimize completion
if [ -d ~/.fzf ]; then
    export PATH="$PATH:$HOME/.fzf/bin"
    source <(~/.fzf/bin/fzf --zsh)
fi

export PATH="$PATH:$HOME/.starship/bin"
export PATH="$PATH:$HOME/.local/bin"

# Experimental (do not enable)
# source $HOME/.zsh/plugins/cmd-hook.zsh

eval "$(sheldon source)"
