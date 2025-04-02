{ config, user, ... }:

{
  home-manager.users.${user} = {
    programs.starship = {
      enable = true;
      settings = builtins.fromTOML ((builtins.readFile ./gruvbox-rainbow.toml)) // {
        palettes.stylix = with config.lib.stylix.colors.withHashtag; {
          color_01 = base01;
          color_02 = base05;
          color_03 = base00;
          color_04 = base04;
          color_05 = base06;
          color_06 = base03;
          color_07 = base0D;
          color_08 = base02;
          color_09 = base0B;
          color_10 = base0F;
          color_11 = base0E;
          color_12 = base08;
          color_13 = base0A;
        };
      };
    };
  };
}
