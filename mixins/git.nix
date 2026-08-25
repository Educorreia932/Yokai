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
      settings = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;
        rebase.autoStash = true;
        user = {
          name = "Eduardo Correia";
          email = "skelozard1@gmail.com";
          signingkey = "~/.ssh/github";
        };
        commit.gpgSign = true;
        tag.forceSignAnnotated = false;
        gpg = {
          format = "ssh";
          ssh.program = "ssh-keygen";
        };
      };
      ignores = [
        ".direnv"
        ".vscode"
        "*.crt"
        "*.key"
        "*.pfx"
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
