## Autoload
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz compinit; compinit -C

# Avoid duplicates in path
typeset -U path PATH

#--------------------------
# Load external extensions
#--------------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# load plugins (zinit)
source $HOME/.zsh/zinit.zsh

#---------------------
# Appearance
#---------------------
# LS_COLOR
source $HOME/.zsh/color.zsh

# Prompt (fallback)
export PS1="[%n@%m %~]%# "

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

# Disable Auto Title (for tmux)
DISABLE_AUTO_TITLE=false

#---------------------
# Import settings
#---------------------
OS="$($HOME/.misc/get-osdist.sh | sed -n 1P)"
PROFILE_DIR="$HOME/.zsh/profile/$OS.zsh"
if [ -e $PROFILE_DIR ]; then
    source $PROFILE_DIR
fi
source $HOME/.zsh/alias.zsh
source $HOME/.zsh/util.zsh

# fzf: Optimize completion
[ -f ~/.fzf.zsh ] && \
    export PATH="$PATH:$HOME/.fzf/bin" && \
    source <(~/.fzf/bin/fzf --zsh)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#export POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
[[ ! -f ~/.p10k.zsh  ]] || source ~/.p10k.zsh && source $HOME/.zsh/p10k.zsh
