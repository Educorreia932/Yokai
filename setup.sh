#!/bin/bash

# Copy files

if [ -d "Dotfiles" ]
then 
    rsync -a ~/Dotfiles/* ~/
fi

# NeoVim 

curl -Lo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo apt install nodejs
nvim -es -c PlugInstall
nvim -es -c CocInstall coc-pairs 

# Git configuration

git config --global user.email "skelozard1@gmail.com"
git config --global user.name "Educorreia932"
git config --global core.editor "nvim"
