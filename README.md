# Educorreia932's Dotfiles 

My current Linux dotfiles and scripts.

# 💻 System Information

These are some of the applications that I use in my current setup.

**Distribution:** NixOS 24.11  
**Desktop Environment:** Gnome 47.1 (Wayland)  
**Shell:** zsh    
**Terminal:** Ptyxis

# 🗃️ Contents
 
- [home](home/) - Home Manager configuration
- [hosts](hosts/) - Host-specific configuration

# 📷 Preview

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

## Hosts 

| Name       | Description |
|------------|-------------|
| `kappa`    | Asus        |
