let
  port = 2812;
in
{
  services.monit = {
    enable = true;
    config = ''
      set daemon 60
      set httpd port ${builtins.toString port}
      allow localhost;
    '';
  };
}
