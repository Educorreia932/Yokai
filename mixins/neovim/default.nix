{ user, ... }:

{
  home-manager.users.${user} = {
    home.file = {
      nvim = {
        source = ./config;
        target = ".config/nvim";
        recursive = true;
      };
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
