{ ... }:

{
  programs.nh = {
    enable = true;

    # Weekly garbage collection, keeping recent generations
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
  };
}
