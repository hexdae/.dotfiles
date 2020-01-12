#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

export DOTFILES=$PWD

git pull origin master;

function doIt() {

	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		# Linux
		source install/linux.sh
	elif [[ "$OSTYPE" == "darwin"* ]]; then
        	# Mac OSX
		source install/osx.sh
	else
		echo "OS not supported"
	fi

	# Sync dotfiles
	rsync 	--exclude ".git/" \
		--exclude ".gitignore" \
                --exclude "install/" \
                --exclude ".DS_Store" \
                --exclude ".packages" \
                --exclude "bootstrap.sh" \
                --exclude "README.md" \
                -avh --no-perms . ~;

	source ~/.profile;
	zsh
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
