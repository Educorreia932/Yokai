{ user, ... }:

{
  home-manager.users.${user} = {
    programs.k9s = {
      enable = true;
    };

    stylix.targets.k9s.enable = true;
  };
}
