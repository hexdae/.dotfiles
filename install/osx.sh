#!/bin/bash

# Install homebrew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install all packages
for package in $(cat $DOTFILES/packages);
do
    which -s $package
    if [[ $? != 0 ]] ; then
        brew install $package;
    else
        echo "[INFO] $package already installed"
    fi
done

# Install Oh-My-Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]
then
    sh -c "$(curl -fsSLhttps://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "[INFO] oh-my-zsh already installed"
fi

# Install powerlevel10k zheme
if [ ! -d "${ZSH:-$HOME/.oh-my-zsh}/themes/powerlevel10k" ]
then
    git clone https://github.com/romkatv/powerlevel10k.git "${ZSH:-$HOME/.oh-my-zsh}/themes/powerlevel10k"
else
    echo "[INFO] powerlevel-10k already installed"
fi

# Install zsh-autosuggestions
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]
then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "[INFO] zsh-autosuggestions already installed"
fi

