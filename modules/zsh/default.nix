{ user, ... }:

{
  home-manager.users.${user} = {
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "1password"
          "git"
          "sudo"
        ];
      };
      initExtra = builtins.readFile ./zshrc;
    };
  };
}
