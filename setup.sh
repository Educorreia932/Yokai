#!/bin/bash

# Copy files

if [ -d "Dotfiles" ]
then 
    rsync -a $HOME/Dotfiles/* $HOME/
fi

# Git configuration

git config --global user.email "skelozard1@gmail.com"
git config --global user.name "Educorreia932"
git config --global core.editor "nvim"

# NeoVim 
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
 
