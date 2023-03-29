#!/usr/bin/env bash


darwin_package_manager() {
    which brew > /dev/null
    if [[ $? != 0 ]]; then
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    brew "$@"
}

linux_package_manager() {
    which sudo
    if [[ $? != 0 ]]; then
        apt-get -y install "$@"
    else
        sudo apt-get install "$@"
    fi
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    MANAGER=linux_package_manager
elif [[ "$OSTYPE" == "darwin"* ]]; then
    MANAGER=darwin_package_manager
else
    echo "OS not supported"
    exit 1
fi

PACKAGES=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

for package in $(cat $PACKAGES/packages.txt); do
    which $package > /dev/null
    if [[ $? != 0 ]]; then
        $MANAGER install $package $OPTIONS
    else
        echo "[INFO] $package already installed"
    fi
done
