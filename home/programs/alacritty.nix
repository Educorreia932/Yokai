{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        dimensions = {
          lines = 30;
          columns = 120;
        };
        padding = {
          x = 10;
          y = 10;
        };
        opacity = 0.95;
      };
      font = {
        size = 13.0;
      };
      shell = "zsh";
    };
  };
}
