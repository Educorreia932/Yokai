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
        stateVersion = "24.11";
        username = "${user}";
        homeDirectory = "/home/${user}";
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
  };
}