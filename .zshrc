# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## Autoload
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit -C

# Avoid duplicates in path
typeset -U path PATH

#--------------------------
# Load external extensions
#--------------------------
#source ${ZDOTDIR:-~}/.antidote/antidote.zsh
#zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins
#
## Ensure the .zsh_plugins.txt file exists so you can add plugins.
#[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt
#
## Lazy-load antidote from its functions directory.
#fpath=(${ZDOTDIR:-~}/.antidote/functions $fpath)
#autoload -Uz antidote
#
## Generate a new static file whenever .zsh_plugins.txt is updated.
#if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
#  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
#fi
#
## Source your static plugins file.
#source ${zsh_plugins}.zsh

#---------------------
# Appearance
#---------------------
# LS_COLOR
source $HOME/.zsh/color.zsh

# Prompt (fallback)
PS1="[%n@%m %~]%# "

# For multiline prompt support
#precmd() { precmd() { echo "" } }
#alias clear="precmd() { precmd() { echo } } && clear"
#function clear() {
#  if (( $+commands[clear] )) && command clear 2>/dev/null; then
#    return
#  fi
#  echoti clear 2>/dev/null
#  print -n -- "\e[H\e[2J\e[3J"
#}

#----------------------
# Keybind
#----------------------
bindkey -e
bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey "^[[3~" delete-char

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

bindkey '^[[Z' reverse-menu-complete

bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

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

setopt complete_in_word
setopt always_last_prompt

setopt nonomatch

zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:options' description 'yes'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache false

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
source $HOME/.zsh/wsl.zsh

# fzf: Optimize completion
[ -f ~/.fzf.zsh ] && \
    export PATH="$PATH:$HOME/.fzf/bin" && \
    source <(~/.fzf/bin/fzf --zsh)

export PATH="$PATH:$HOME/.starship/bin"
export PATH="$PATH:$HOME/.local/bin"
#[[ $(which starship) ]] && eval "$(starship init zsh)"
eval "$(sheldon source)"
# source $HOME/.zsh/git.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh && source ~/.zsh/p10k.zsh
