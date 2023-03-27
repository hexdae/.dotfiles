#!/usr/bin/env bash

set -eu pipefail

DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function setup() {

    # Install homebrew if needed
    which brew > /dev/null
    if [[ $? != 0 ]] ; then
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi

    # Install all packages
    brew bundle install --file "$DOTFILES/brew/Brewfile"

    for USER_FILE in "$DOTFILES"/user/.*; do

        local DOTFILE="$(basename $USER_FILE)"

        if [[ ! "$DOTFILE" =~ .DS_Store$|.git$|^.$|^..$ ]]; then
            # Backup the file if it is present
            if [[ -f "$HOME/$DOTFILE" ]] || [[ -d "$HOME"/$DOTFILE ]] ;then
                # Remove backup symlink directories to avoid duplication
                [[ -d "$HOME/$DOTFILE.backup" ]] && rm "$HOME/$DOTFILE.backup"
                # Copy the current file to its backup
                echo "[INFO] backing up original $DOTFILE"
                mv "$HOME/$DOTFILE" "$HOME/$DOTFILE.backup"
            fi

            # Create a symlink to the .dotfile in this folder
            ln -snf "$USER_FILE" "$HOME/$DOTFILE";

        fi;
    done

}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    setup;
else
    read -p "This may rename existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        setup;
        zsh;
    fi;
fi;
