#!/bin/bash

# Copy files

if [ -d "Dotfiles" ]
then 
    rsync -a ~/Dotfiles/* ~/
fi

# Git configuration

git config --global user.email "skelozard1@gmail.com"
git config --global user.name "Educorreia932"
git config --global core.editor "nvim"

# NeoVim 

curl -Lo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo apt install nodejs
nvim -es -c PlugInstall
nvim -es -c CocInstall coc-pairs 

# CCLS

cd ~

git clone --depth=1 --recursive https://github.com/MaskRay/ccls

cd ccls

sudo apt install clang cmake libclang-dev llvm-dev rapidjson-dev
cmake -H. -BRelease
cmake --build Release

mv Release/ccls ~/.local/bin

cd ~
rm -rf ccls

