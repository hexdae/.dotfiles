#!/bin/bash

# Install homebrew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install all packages
for package in $(cat $DOTFILES/install/packages);
do
    which -s $package
    if [[ $? != 0 ]] ; then
        brew install $package;
    else
        echo "[INFO] $package already installed"
    fi
done
