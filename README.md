<div align=center>
    <img src="kitsune.png" alt="Kitsune" height="200"/>
    <h1>Yōkai</h1>
</div>

This is my personal Nix(OS) configuration that I use across my machines.

> Illustrations by [いらすとや](https://www.irasutoya.com/2013/05/blog-post_14.html)

# 🗃️ Contents
 
- [hosts/](hosts/) - Host-specific configuration
- [modules/](modules/) - Individual application configuration

## Useful Commands

### Rebuild (NixOS)

```sh
sudo nixos-rebuild switch --flake .#<hostname>
```

### Rebuild (Darwin)

```sh
darwin-rebuild switch --flake .#<hostname>
```

### Update

```sh
nix flake update
```

### Garbage Collection

```sh
sudo nix-collect-garbage
```

## Hosts 

| Icon | Name       | Description            | Hardware                           | System        |
|:----:|------------|------------------------|------------------------------------|---------------|
|  🐈‍⬛  | `bakeneko` | Personal laptop (new)  | ASUS ROG Zephyrus G16 (2024) GU605 | Windows (WSL) |
|  🕷️  | `jorogumo` | Work laptop            | MacBook Pro M3                     | macOS         |
|  🐸  | `kappa`    | Personal laptop (old)  | ASUS ROG Zephyrus GX701            | NixOS         |
|  👺  | `tengu`    | Virtual private server | Hetzner Cloud Server               | NixOS         |

