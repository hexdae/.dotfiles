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

	exclude=\
	( \
		".install/" \
		".git/" \
		".gitignore"\
		".DS_Store"\
		".packages"\
		"bootstrap.sh"\
		"README.md"\
       	)

	for file in *; do
    		for (( index = 0; index < ${#exclude[@]}; index++ )); do
        		if [[ ${file} != ${exclude[${index}]} ]]; then
				# If the file exists remove it
				[[if -f ~/${file} ]] && rm ~/${file}
				# Create a link in the home folder
				ln -s ${file} ~/${file}
        		fi
    		done
	done

	# Start default shell
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
