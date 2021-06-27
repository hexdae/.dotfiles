# Allow for optional local configuration
if [ -f "$HOME/.localrc" ]
then
    source "$HOME/.localrc"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Select theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-autosuggestions)

# Source Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Source theme configuration
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Source common files
source ~/.profile
