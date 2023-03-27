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
    pushd brew > /dev/null && brew bundle install && popd > /dev/null || exit 1

    pushd user > /dev/null || exit 1

    for dotfile in .*; do
        if [[ ! "$dotfile" =~ .DS_Store$|.git$|^.$|^..$ ]]; then
                # Backup the file if it is present
                if [[ -f "$HOME/$dotfile" ]] || [[ -d "$HOME"/$dotfile ]] ;then
                    echo "[INFO] backing up original $dotfile"
                    [[ -f "$HOME/$dotfile.backup" ]] && rm "$HOME/$dotfile.backup"
                    [[ -d "$HOME/$dotfile.backup" ]] && rm "$HOME/$dotfile.backup"
                    mv "$HOME/$dotfile" "$HOME/$dotfile.backup"
                fi
                # Create a symlink to the .dotfile in this folder
                ln -snf "$DOTFILES/user/$dotfile" "$HOME/$dotfile";
        fi;
    done

    popd > /dev/null || exit 1
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
