#!/usr/bin/env bash

set -eu

function setup() {
    DOTFILES=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

    # Install required packages
    $DOTFILES/packages/install.sh

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
