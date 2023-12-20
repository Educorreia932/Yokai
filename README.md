# Educorreia932's Dotfiles 

My current Linux dotfiles and scripts.

# 💻 System Information

These are some of the applications that I use in my current setup.

**Distribution:** Nix OS  
**Desktop Environment:** i3  
**Bar:** Polybar  
**Shell:** zsh  
**Terminal:** Alacritty  
**Text Editor:** NeoVim

# 📷 Screenshot

![Preview](preview.png)

# Useful Commands

## Rebuild

```sh
sudo nixos-rebuild switch --flake .#asus --impure
```

## Update

```sh
nix flake update
```

## TODO

- Switch home-manager faster
  - https://github.com/nmasur/dotfiles/blob/90092c48ec682ec09ff0c9aaa491d6509be7cc2a/flake.nix#L245C22-L245C22
- Replace "eduardo" with `config.user` in `/modules`
- > error: cannot look up '<nixpkgs>' in pure evaluation mode (use '--impure' to override)