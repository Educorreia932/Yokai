# Copy files

echo "Do you want to copy the the configuration files and folders? [Y/n]"
read -n 1 -r; \
    if [[ $$REPLY =~ ^[Yy] ]]; \
    then \
        rsync -avzP ~/Dotfiles/* ~/; \
    fi

# vim-plug 

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
sudo apt install nodejs

# Git configuration

git config --global user.email "skelozard1@gmail.com"
git config --global user.name "Educorreia932"

