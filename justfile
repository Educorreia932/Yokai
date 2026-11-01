set shell := ["zsh", "-cu"]

# List all the just commands
default:
    just --list

# Delete old generations
clean:
    nh clean all

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
        nh darwin switch . -H {{ host }}; \
    else \
        nh os switch . -H {{ host }}; \
    fi

# Rebuild the system configuration for a specific host
[group('deployment')]
deploy host target: rebuild-pre
    nh os switch . -H {{ host }} --target-host {{ target }}

[group('deployment')]
deploy-tengu:
    just deploy tengu eduardo@educorreia932.dev

# Create or update a secret
[group('secrets')]
secrets-edit name:
    cd secrets && agenix -e {{ name }}.age

alias secrets-create := secrets-edit

# Delete a secret file
[group('secrets')]
secrets-delete name:
    cd secrets && rm {{ name }}.age

# Rekey all secrets
[group('secrets')]
secrets-rekey:
    cd secrets && agenix -r
