#!/bin/bash 

# Install Oh-My-Zsh
sh -c "$(curl -fsSLhttps://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install powerlevel10k zheme
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

echo "ZSH_THEME=powerlevel10k/powerlevel" >> ~/.zshrc
