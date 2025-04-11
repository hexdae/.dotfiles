# Allow for optional local configuration
if [ -f "$HOME/.localrc" ]
then
  source "$HOME/.localrc"
fi

# Source common files
source ~/.profile

eval "$(starship init bash)"
