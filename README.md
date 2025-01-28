# Educorreia932's Dotfiles 

My current Linux dotfiles and scripts.

# 🗃️ Contents
 
- [hosts](hosts/) - Host-specific configuration
- [modules](modules/) - Individual application configuration

# Useful Commands

## Rebuild (NixOS)

```sh
sudo nixos-rebuild switch --flake .#<hostname>
```

## Rebuild (darwin)

```sh
darwin-rebuild switch --flake .#<hostname>
```

## Update

```sh
nix flake update
```

## Garbage Collection

```sh
sudo nix-collect-garbage -d
```

## Hosts 

| Icon | Name       | Description            | Hardware                           |
|:----:|------------|------------------------|------------------------------------|
|  🐈‍⬛  | `bakeneko` | Personal laptop (new)  | ASUS ROG Zephyrus G16 (2024) GU605 |
|  🕷️  | `jorogumo` | Work laptop            | MacBook Pro M3                     |
|  🐸  | `kappa`    | Personal laptop (old)  | ASUS ROG Zephyrus GX701            |
|  👺  | `tengu`    | Virtual private server | Hetzner Cloud Server               |
