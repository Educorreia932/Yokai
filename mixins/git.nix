{ user, ... }:

{
  home-manager.users.${user} = {
    programs.git = {
      enable = true;
      ignores = [
        ".direnv"
        ".vscode"
      ];
    };
  };
}
