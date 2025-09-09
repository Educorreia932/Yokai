set shell := ["zsh", "-cu"]

# List all the just commands
default:
    just --list

# Delete old generations
clean:
    sudo nix-collect-garbage --delete-old

# Update the flake.lock file
update:
    nix flake update

[private]
rebuild-pre:
    git add -A

# Rebuild the system configuration
rebuild HOST: rebuild-pre
    if [[ "{{HOST}}" == "jorogumo" ]]; then \
        sudo darwin-rebuild switch --flake .#{{HOST}}; \
    else \
        sudo nixos-rebuild switch --flake .#{{HOST}}; \
    fi

# Rebuild the system configuration for a specific host
deploy HOST TARGET: rebuild-pre
    nixos-rebuild switch --flake .#{{HOST}} \
        --target-host {{TARGET}} \
        --use-remote-sudo \
        --show-trace

deploy-tengu:
    just deploy tengu eduardo@educorreia932.dev
