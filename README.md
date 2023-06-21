# Educorreia932's Dotfiles 

My current Linux dotfiles and scripts.

# 💻 System Information

These are some of the applications that I use in my current setup.

**Distribution:** Nix OS  
**Desktop Environment:** Gnome  
**Shell:** zsh  
**Terminal:** Alacritty  
**Text Editor:** NeoVim

# 📷 Screenshot

![Preview](preview.png)

# Commands

## Rebuild

```sh
sudo nixos-rebuild switch --flake .#asus
```

## ASUS CTL

### Start service

```sh
systemctl start asusd
```

### Change settings

```sh
asusctl
```
