# Allow for optional local configuration
if [ -f "$HOME/.localrc" ]
then
    source "$HOME/.localrc"
fi

# Source common files
source ~/.profile

# zsh
export ZSH="$HOME/.zsh/oh-my-zsh"
export ZSH_CUSTOM="$HOME/.zsh"
plugins=(git fzf zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

# Added by diode installer
autoload -Uz compinit && compinit
