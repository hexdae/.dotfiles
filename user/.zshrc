# Allow for optional local configuration
if [ -f "$HOME/.localrc" ]
then
    source "$HOME/.localrc"
fi

# Prompt
source <($(which starship) init zsh --print-full-init)

# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Source common files
source ~/.profile

