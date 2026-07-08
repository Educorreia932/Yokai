set shell := ["zsh", "-cu"]

# List all the just commands
default:
    just --list

# Delete old generations
clean:
    sudo nix-collect-garbage --delete-old

# Update the flake.lock file
[group('flake')]
update:
    nix flake update

# Check the flake for errors 
[group('flake')]
check:
    nix flake check --all-systems

# Format everything
format:
    treefmt

[private]
rebuild-pre:
    git add -A

# Rebuild the system configuration
rebuild host: rebuild-pre
    if nix eval --json .#darwinConfigurations --apply builtins.attrNames 2>/dev/null | grep -q '"{{ host }}"'; then \
        sudo darwin-rebuild switch --flake .#{{ host }}; \
    else \
        sudo nixos-rebuild switch --flake .#{{ host }}; \
    fi

# Rebuild the system configuration for a specific host
[group('deployment')]
deploy host target: rebuild-pre
    nixos-rebuild switch --flake .#{{ host }} \
        --target-host {{ target }} \
        --sudo \
        --show-trace

# Alias to "just deploy tengu eduardo@educorreia932.dev"
[group('deployment')]
deploy-tengu:
    just deploy tengu eduardo@educorreia932.dev

# Preview infrastructure changes
[group('infrastructure')]
infra-plan:
    nix run .#infra-plan

# Apply infrastructure changes
[group('infrastructure')]
infra-apply:
    nix run .#infra-apply

# Destroy infrastructure
[group('infrastructure')]
infra-destroy:
    nix run .#infra-destroy

# Create or update a secret
[group('secrets')]
secret-edit name:
    cd secrets && agenix -e {{ name }}.age

alias secret-create := secret-edit

# Delete a secret file
[group('secrets')]
secret-delete name:
    cd secrets && rm {{ name }}.age

# Rekey all secrets (run after adding a new public key)
[group('secrets')]
secret-rekey:
    cd secrets && agenix -r
