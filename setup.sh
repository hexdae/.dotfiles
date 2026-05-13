#!/usr/bin/env bash

set -eu

function install() {

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get >/dev/null 2>&1; then
            # Debian / Ubuntu
            sudo add-apt-repository -y ppa:aslatter/ppa || echo "[WARN] could not add aslatter PPA, continuing..."
            INSTALL="sudo apt-get -y install"
        elif command -v dnf >/dev/null 2>&1; then
            # Fedora / RHEL / Amazon Linux 2023
            INSTALL="sudo dnf -y install"
        elif command -v yum >/dev/null 2>&1; then
            # Older RHEL / CentOS
            INSTALL="sudo yum -y install"
        else
            echo "[ERROR] No supported package manager found (apt-get, dnf, yum)"
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        which brew > /dev/null || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        INSTALL="brew install"
    else
        echo "OS not supported"
        exit 1
    fi

    # Install packages, allowing graceful failure for each.
    # cyme isn't packaged on most distros — falls through to the warning and
    # can be installed later via `cargo install cyme` if desired.
    for pkg in zsh wget vim bat ripgrep gh fzf cyme; do
        $INSTALL $pkg || echo "[WARN] Failed to install $pkg, continuing..."
    done

    # Make bin dir
    mkdir -p $HOME/bin
    
    # Staship install
    which starship > /dev/null || sh <(curl -sS https://starship.rs/install.sh) -y --bin-dir $HOME/bin
}

function set_default_shell() {

    local ZSH_PATH
    ZSH_PATH="$(command -v zsh || true)"
    if [[ -z "$ZSH_PATH" ]]; then
        echo "[WARN] zsh not installed, skipping default shell change"
        return
    fi

    # Ensure zsh is registered in /etc/shells (required by chsh on most distros)
    if [[ -w /etc/shells ]] || sudo -n true 2>/dev/null; then
        if ! grep -qx "$ZSH_PATH" /etc/shells 2>/dev/null; then
            echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null || true
        fi
    fi

    local CURRENT_SHELL
    CURRENT_SHELL="$(getent passwd "$USER" 2>/dev/null | cut -d: -f7)"
    if [[ "$CURRENT_SHELL" == "$ZSH_PATH" ]]; then
        return
    fi

    if command -v chsh >/dev/null 2>&1; then
        chsh -s "$ZSH_PATH" "$USER" 2>/dev/null \
            || sudo chsh -s "$ZSH_PATH" "$USER" \
            || echo "[WARN] could not change default shell to $ZSH_PATH"
    elif command -v usermod >/dev/null 2>&1; then
        sudo usermod -s "$ZSH_PATH" "$USER" \
            || echo "[WARN] could not change default shell to $ZSH_PATH"
    else
        echo "[WARN] neither chsh nor usermod available; default shell unchanged"
    fi
}

function setup() {

    # Install required packges
    install

    # Make zsh the login shell
    set_default_shell

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
