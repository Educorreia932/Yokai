# Copy files

echo "Do you want to copy the the configuration files and folders?"
read -n 1 -r; \
    if [[ $$REPLY =~ ^[Yy] ]]; \
    then \
        rsync -avzP ~/Dotfiles/* ~/; \
    fi

# vim-plug 

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
sudo apt install nodejs
