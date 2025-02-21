<div align=center>
    <img src="_img/kitsune.png" alt="Kitsune" height="200"/>
    <h1>Yōkai</h1>
</div>

This is my personal [Nix(OS)](https://nixos.org/) configuration that I use across my machines.

> Illustrations by [いらすとや](https://www.irasutoya.com/2013/05/blog-post_14.html)

## 🗃️ Contents
 
- [hosts/](hosts/) - Host-specific configuration
- [lib/](lib/): Helper functions and attributes
- [mixins/](mixins/) - Individual application configuration
- [modules/](modules/) - Modules that can be enabled and configured through options
- [overlays/](modules/) - Overlays to `nixpkgs`
- [pkgs/](pkgs/) - Custom packages definitions
- [secrets/](secrets/) - Encrypted secrets

## 💻 Hosts 

| Icon | Name       | Description            | Hardware                           | System        |
|:----:|------------|------------------------|------------------------------------|---------------|
|  🐈‍⬛  | `bakeneko` | Personal laptop (new)  | ASUS ROG Zephyrus G16 (2024) GU605 | Windows (WSL) |
|  🕷️  | `jorogumo` | Work laptop            | MacBook Pro M3                     | macOS         |
|  🐸  | `kappa`    | Personal laptop (old)  | ASUS ROG Zephyrus GX701            | NixOS         |
|  👺  | `tengu`    | Virtual private server | Hetzner Cloud Server               | NixOS         |

## 📜 System Management

### ⚒️ Rebuild (NixOS)

```sh
sudo nixos-rebuild switch --flake .#<hostname>
```

### ⚒️ Rebuild (Darwin)

```sh
darwin-rebuild switch --flake .#<hostname>
```

### 🔄 Update

To update the `flake.lock` file:

```sh
nix flake update
```

### ♻️ Garbage Collection

To remove unused packages:

```sh
sudo nix-collect-garbage
```
