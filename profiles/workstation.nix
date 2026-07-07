{ ... }:

# Interactive workstation profile (personal/work laptops)
# Extends the common baseline with developer conveniences
{
  imports = [
    ./common.nix
    ../mixins/git.nix
    ../mixins/lf.nix
  ];
}
