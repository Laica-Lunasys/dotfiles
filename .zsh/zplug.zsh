source ~/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "robbyrussell/oh-my-zsh", use:lib/termsupport.zsh, as:plugin

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    echo; zplug install
fi

# Then, source plugins and add commands to $PATH
zplug load
