#rm -f $HOME/.antigen/.zcompdump

# antigen
source $HOME/.antigen/antigen.zsh

# Load oh-my-zsh
#antigen use oh-my-zsh

# Bundle from oh-my-zsh
antigen bundle git
antigen bundle docker

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply
