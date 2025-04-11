#!/usr/bin/env bash

set -eu

function install() {

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then        
        sudo add-apt-repository -y ppa:aslatter/ppa
        INSTALL="sudo apt-get -y install"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        which brew > /dev/null || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        INSTALL="brew install"
    else
        echo "OS not supported"
        exit 1
    fi

    # Install packages
    $INSTALL zsh wget vim nushell
    
    # Make bin dir
    mkdir -p $HOME/bin
    
    # Staship install
    which starship > /dev/null || sh <(curl -sS https://starship.rs/install.sh) -y --bin-dir $HOME/bin
}

function setup() {

    # Install required packges
    install

    DOTFILES=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

    for USER_FILE in "$DOTFILES"/user/.*; do

        local DOTFILE="$(basename $USER_FILE)"

        if [[ ! "$DOTFILE" =~ .DS_Store$|.git$|^.$|^..$ ]]; then

            # Backup the file if it is present
            if [[ -f "$HOME/$DOTFILE" ]] || [[ -d "$HOME"/$DOTFILE ]]; then
                
                # Remove backup symlink directories to avoid duplication
                [[ -d "$HOME/$DOTFILE.backup" ]] && rm "$HOME/$DOTFILE.backup"
                
                # Copy the current file to its backup
                echo "[INFO] backing up original $DOTFILE"
                mv "$HOME/$DOTFILE" "$HOME/$DOTFILE.backup"
            fi

            # Create a symlink to the .dotfile in this folder
            ln -snf "$USER_FILE" "$HOME/$DOTFILE"
        fi
    done

}

if [ "${1:-' '}" != "--force" ]; then
    echo '[INFO] This may rename existing files in your home directory.'
    read -p '[INFO] press ENTER to contine'
fi

setup
zsh
