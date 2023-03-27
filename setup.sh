#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")" || exit 1;

export DOTFILES=$PWD

git pull origin master;

function setup() {

    # Install homebrew if needed
    which -s brew
    if [[ $? != 0 ]] ; then
        # Install Homebrew
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # Install all packages
    brew bundle install --file brew/Brewfile

    for USER_FILE in user/.*; do
        local DOTFILE="$(basename $USER_FILE)"
        if [[ ! "$DOTFILE" =~ .DS_Store$|.git$|^.$|^..$ ]]; then
            # Backup the file if it is present
            if [[ -f "$HOME/$DOTFILE" ]] || [[ -d "$HOME"/$DOTFILE ]] ;then
                # Discard previous backups if they were there
                [[ -f "$HOME/$DOTFILE.backup" ]] || [[ -d "$HOME/$DOTFILE.backup" ]] && rm "$HOME/$DOTFILE.backup"
                # Copy the current file to its backup
                echo "[INFO] backing up original $DOTFILE"
                mv "$HOME/$DOTFILE" "$HOME/$DOTFILE.backup"
            fi
            # Create a symlink to the .dotfile in this folder
            ln -snf "$DOTFILES/$USER_FILE" "$HOME/$DOTFILE";
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
