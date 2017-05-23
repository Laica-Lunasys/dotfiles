#===================================#
# Synchthia Server / zsh Config 1.0 #
# Author: Laica-Lunasys             #
#===================================#

# Basic setting
autoload -U colors; colors
source $HOME/.zshrc_color
source $HOME/.zshrc_alias
source $HOME/.zshrc_format

case "$OSTYPE" in
    linux*)
        source $HOME/.zshrc_linux
        ;;
    freebsd*|darwin*)
        source $HOME/.zshrc_bsd
        ;;
esac

if [ -e $HOME/.zsh_profile ]; then
source $HOME/.zsh_profile
fi

# oh-my-zsh
DISABLE_AUTO_TITLE=true
ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
plugins=(brew bundler capistrano coffee command-not-found extract gem git git-flow github heroku history history-substring-search lein mvn node npm pip python rails rake rbenv redis-cli rsync ruby svn thor urltools vagrant vi-mode vundle yum zsh-syntax-highlighting)

setopt correct
setopt prompt_subst
setopt nonomatch

# 補完を有効にする
autoload -Uz compinit; compinit -u

# 補完オプション
setopt auto_param_slash
setopt mark_dirs       
setopt list_types           
setopt auto_menu             
setopt auto_param_keys       
setopt interactive_comments  
setopt magic_equal_subst     

setopt complete_in_word      
setopt always_last_prompt    

# 補完メッセージを読みやすくする
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $text_yellow'%d'$reset_color
zstyle ':completion:*:warnings' format $text_red'No matches for:'$text_yellow' %d'$reset_color
zstyle ':completion:*:descriptions' format $text_yellow'completing %B%d%b'$reset_color
zstyle ':completion:*:corrections' format $text_yellow'%B%d '$text_red'(errors: %e)%b'$reset_color
zstyle ':completion:*:options' description 'yes'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-separator ">>"
zstyle ':completion:*' use-cache true

# Bind Key
bindkey -e
bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey "^[[3~" delete-char

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Prompt Setting
# a;b;c(m%)
# a(48=bg, 38=fg) b(static) c(colornum)
# 148m = green
#GREEN: PROMPT=$'%{\e[38;5;22;48;5;148m%} %n@%m %{\e[38;5;231;48;5;240m%} %~ \n%{\e[38;5;245;48;5;236m%} %(!.#.$) %{\e[m%} '
#PROMPT=$'%{\e[38;5;23;48;5;231m%} %n@%m %{\e[38;5;231;48;5;31m%} %~ \n%{\e[38;5;117;48;5;24m%} %(!.#.$) %{\e[m%} '
#BLUE: PROMPT=$'%{\e[38;5;231;48;5;31m%} %n@%m %{\e[38;5;117;48;5;24m%} %~ \n%{\e[38;5;245;48;5;236m%} %(!.#.$) %{\e[m%} '
PROMPT=$'%{\e[38;5;231;48;5;31m%} %n@%m %{\e[38;5;231;48;5;240m%} %~ \n%{\e[38;5;245;48;5;236m%} %(!.#.$) %{\e[m%} '

SPROMPT="%{$fg[white]%}%{$suggest%}(✿>╹‸╹%)? < にゃえ？もしかして %B%r%b %{$fg[white]%}のことかな? [そう!(y), 違う!(n),a,e]:${reset_color} "
