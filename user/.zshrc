# Allow for optional local configuration
if [ -f "$HOME/.localrc" ]
then
    source "$HOME/.localrc"
fi

# Prompt
source <($(which starship) init zsh --print-full-init)

# zsh management
export ZSH="$HOME/.zsh/oh-my-zsh"
export ZSH_CUSTOM="$HOME/.zsh"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# Source common files
source ~/.profile


