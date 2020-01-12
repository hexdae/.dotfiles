# If you come from bash you might have to change your $PATH.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Select theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git)

# Source Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Source theme configuration
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


