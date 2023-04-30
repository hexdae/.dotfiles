#!/usr/bin/env bash


if [[ "$OSTYPE" == "linux-gnu"* ]]; then
 
    sudo add-apt-repository ppa:aslatter/ppa -y
    INSTALL="sudo apt-get -y install"

    
elif [[ "$OSTYPE" == "darwin"* ]]; then
    
    which brew > /dev/null
    if [[ $? != 0 ]]; then
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    INSTALL="brew install"

else
    echo "OS not supported"
    exit 1
fi


PACKAGES="zsh wget vim starship helix zellij alacritty"
$INSTALL $PACKAGES
