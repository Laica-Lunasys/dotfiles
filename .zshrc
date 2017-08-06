#--------------------------
# zsh Configuration
#--------------------------
## Autoload
autoload -U colors; colors
autoload -U compinit; compinit -u
autoload -U vcs_info

# Init Antigen
source $HOME/.zsh/antigen.zsh

#-----------------------
# Misc Settings
#-----------------------
# History
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Disable Auto Title (for tmux)
DISABLE_AUTO_TITLE=true

#----------------------
# Bind Key
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

#----------------
# Tab Complete
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

zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:options' description 'yes'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache true

#---------------------
# Import settings
#---------------------
OS="$($HOME/.zsh/check-os.zsh checkos)"
PROFILE_DIR="$HOME/.zsh/profile/$OS.zsh"
if [ -e $PROFILE_DIR ]; then
    source $PROFILE_DIR
fi

if [ -e $HOME/.zsh_profile ]; then
    source $HOME/.zsh_profile
fi

source $HOME/.zsh/color.zsh
source $HOME/.zsh/alias.zsh

source $HOME/.zsh/vcs.zsh
source $HOME/.zsh/prompt.zsh