#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

export DOTFILES=$PWD

git pull origin master;

function setup() {

	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		source install/linux.sh
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		source install/osx.sh
	else
		echo "OS not supported"
	fi

	for file in .*; do
	    if [[ ! "$file" =~ .DS_Store$|.git$|.gitignore$ ]]; then
			# If the file is not a directory create a link
			if [[ ! -d "$file" ]]; then
				# Backup the file if it is present
				[[ -f "$HOME/$file" ]] && mv "$HOME/$file" "$HOME/$file.backup"
				# Create a symlink to the .dotfile in this folder
				ln -sf "$DOTFILES/$file" "$HOME/$file";
			fi;
		fi;
    done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may rename existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		setup;
		zsh;
	fi;
fi;