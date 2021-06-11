#!/bin/bash

# Install required packages
# Install all packages
for package in $(cat $DOTFILES/packages);
do
    which -s $package
    if [[ $? != 0 ]] ; then
        sudo apt-get install $package;
    else
        echo "$package already installed"
    fi
done

# Download Oh-My-Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]
then
    sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
else
    echo "oh-my-zsh already installed"
fi

# Install powerlevel10k zheme
if [ ! -d "${ZSH:-$HOME/.oh-my-zsh}/themes/powerlevel10k" ]
then
    git clone https://github.com/romkatv/powerlevel10k.git "${ZSH:-$HOME/.oh-my-zsh}/themes/powerlevel10k"
else
    echo "powerlevel-10k already installed"
fi

# Install zsh-autosuggestions
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]
then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions already installed"
fi