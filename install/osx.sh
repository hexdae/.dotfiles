#!/bin/bash 

# Install homebrew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# Install all packages
brew install $(cat $DOTFILES/packages)

# Install Oh-My-Zsh
if [ ! -d "$HOME/.oh-my-zsh" ] 
then
    sh -c "$(curl -fsSLhttps://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Install powerlevel10k zheme
if [ ! -d "$HOME/.oh-my-zsh/themes/powerlevel10k" ] 
then
    git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/themes/powerlevel10k
fi
