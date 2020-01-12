# Linux installation scripts

# Install zsh
sudo apt-get install zsh

# Install git and wget 
sudo apt-get install wget git

# Download Oh-My-Zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

# Install powerlevel10k zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
echo "ZSH_THEME=powerlevel10k/powerlevel" >> ~/.zshrc
