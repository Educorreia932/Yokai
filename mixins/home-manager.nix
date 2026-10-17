{ inputs, user, ... }:

{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs user; };
    backupFileExtension = "backup";
    users.${user} = {
      # Home configuration
      home = {
        stateVersion = "26.05";
        username = "${user}";
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
  };
}
