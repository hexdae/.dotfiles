#!/bin/bash

# Install required packages
for package in $(cat $DOTFILES/install/packages);
do
    which -s $package
    if [[ $? != 0 ]] ; then
        sudo apt-get install $package;
    else
        echo "[INFO] $package already installed"
    fi
done
