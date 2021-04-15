#!/bin/bash

# Copy files

if [ -d "~/Dotfiles" ]
then 
    rsync -avzP ~/Dotfiles/* ~/
fi

# vim-plug 

curl -Lo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -es -c PlugInstall
sudo apt install nodejs

# Git configuration

git config --global user.email "skelozard1@gmail.com"
git config --global user.name "Educorreia932"
git config --global core.editor "nvim"
