{ user, pkgs, ... }:

{
  users.users.${user}.shell = pkgs.zsh;
  programs.zsh.enable = true;

  home-manager.users.${user} = {
    home.packages = with pkgs; [
      fzf
    ];
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "1password"
          "git"
          "sudo"
          "fzf"
        ];
      };
      initExtra = builtins.readFile ./zshrc;
    };
  };
}
