#!/usr/bin/env bash


if [[ "$OSTYPE" == "linux-gnu"* ]]; then
 
    sudo || true
    add-apt-repository ppa:aslatter/ppa -y
    MANAGER="apt-get -y"

    
elif [[ "$OSTYPE" == "darwin"* ]]; then
    
    which brew > /dev/null
    if [[ $? != 0 ]]; then
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    MANAGER="brew"

else
    echo "OS not supported"
    exit 1
fi


PACKAGES="zsh wget vim starship helix zellij alacritty"
$MANAGER install $PACKAGES
