#!/bin/bash

# Install required packages
sudo apt-get install $(cat $DOTFILES/.packages)

# Download Oh-My-Zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

# Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/themes/powerlevel10k;

