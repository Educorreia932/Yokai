# List all the just commands
default:
    just --list

# Delete old generations
clean:
    sudo nix-collect-garbage --delete-old

[private]
rebuild-pre:
    git add *.nix

# Rebuild the system configuration
rebuild HOST: rebuild-pre
    sudo nixos-rebuild switch --flake .#{{HOST}}

# Rebuild the system configuration for a specific host
deploy HOST TARGET: rebuild-pre
    nixos-rebuild switch --flake .#{{HOST}} \
        --target-host {{TARGET}} \
        --use-remote-sudo \
        --show-trace

deploy-tengu:
    just deploy tengu eduardo@educorreia932.dev
