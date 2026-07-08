<div align=center>
    <img src="_img/kitsune.png" alt="Kitsune" height="200"/>
    <h1>Yōkai</h1>
</div>

This is my personal [Nix(OS)](https://nixos.org/) configuration that I use across my machines.

I use `just` as a task runner to manage my configuration. You can run `just --list` to see all available tasks.

> Illustrations by [いらすとや](https://www.irasutoya.com/2013/05/blog-post_14.html)

## 🗃️ Contents
 
- [hosts/](hosts/) - Host-specific configuration
- [infrastructure/](infrastructure/) - Cloud infrastructure provisioning
- [lib/](lib/): Helper functions and attributes
- [mixins/](mixins/) - Individual application configuration
- [profiles/](profiles/) - Profiles that can be applied to hosts
- [modules/](modules/) - Modules that can be enabled and configured through options
- [overlays/](modules/) - Overlays to `nixpkgs`
- [pkgs/](pkgs/) - Custom packages definitions
- [secrets/](secrets/) - Encrypted secrets

## 💻 Hosts 

| Icon | Name       | Description            | Hardware                           | System        |
|:----:|------------|------------------------|------------------------------------|---------------|
|  🐈‍⬛  | `bakeneko` | Personal laptop (new)  | ASUS ROG Zephyrus G16 (2024) GU605 | Windows (WSL) |
|  🕷️  | `jorogumo` | Work laptop            | MacBook Pro M3                     | macOS         |
|  👺  | `tengu`    | Virtual private server | Hetzner Cloud Server               | NixOS         |

## ☁️ Infrastructure

The [`tengu`](hosts/tengu/) server runs on [Hetzner Cloud](https://www.hetzner.com/cloud/), and its resources are declared with [Terranix](https://terranix.org/).
