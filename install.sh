#! /usr/bin/env bash

git clone --recurse-submodules https://github.com/hexdae/.dotfiles.git $HOME/.dotfiles || echo "FAIL" 

$HOME/.dotfiles/setup.sh
