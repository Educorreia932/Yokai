{
  config,
  lib,
  user,
  ...
}:

{
  home-manager.users.${user} = {
    programs.lf = {
      enable = true;
    };

    programs.zsh = lib.mkIf config.programs.zsh.enable {
      initContent = ''
        # Change directory to the last directory used
        function lfcd () {
          # `command` is needed in case `lfcd` is aliased to `lf`
          cd "$(command lf -print-last-dir "$@")"
        }
      '';

      shellAliases = {
        lf = "lfcd";
      };
    };
  };
}
