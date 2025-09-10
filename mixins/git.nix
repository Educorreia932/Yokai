{
  config,
  lib,
  user,
  ...
}:

{
  home-manager.users.${user} = {
    programs.git = {
      enable = true;
      ignores = [
        ".direnv"
        ".vscode"
      ];
    };

    programs.zsh = lib.mkIf config.programs.zsh.enable {
      initContent = ''
        function git-clear() {
          # Update remote references
          git fetch --prune
          # Remove local branches that no longer exist on remote
          git branch -vv --format '%(upstream:track):%(refname:short)' | awk -F: '$1 == "[gone]" {print $2}' | xargs -rp git branch -D
        }
      '';
    };
  };
}
