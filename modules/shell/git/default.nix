{
  home-manager.users.eduardo = {
    programs.git = {
      enable = true;
      userName = "Educorreia932";
      userEmail = "skelozard1@gmail.com";
      ignores = [
        ".direnv"
        ".vscode"
      ];
    };
  };
}
