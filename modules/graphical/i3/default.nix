{ config, lib, pkgs, ... }:

with lib;

{
  services.xserver.windowManager.i3 = {
    package = pkgs.i3-gaps;
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status
      i3lock
    ];
  };

  home-manager.users.eduardo = {
    xsession.windowManager.i3 = {
      enable = config.services.xserver.enable;
      config =
        let
          mod = "Mod4"; # Super key
          ws1 = "1";
          ws2 = "2";
          ws3 = "3";
          ws4 = "4";
          ws5 = "5";
          ws6 = "6";
          ws7 = "7";
          ws8 = "8";
          ws9 = "9";
          ws10 = "10";
        in
        {
          modifier = mod;
          floating.modifier = mod;
          focus = {
            mouseWarping = true;
            newWindow = "urgent";
            followMouse = false;
          };
          keybindings = {
            # Launch terminal
            "${mod}+Return" = "exec alacritty";

            # Launch dmenu
            "${mod}+d" = "exec rofi -show combi -combi-modi window,drun -show-icons -modi combi";

            # Reload the configuration file
            "${mod}+Shift+c" = "reload";

            # Restart i3 inplace
            "${mod}+Shift+r" = "restart";

            # Scroll trough workspaces
            "${mod}+Tab" = "workspace back_and_forth";

            # Window options
            "${mod}+Shift+q" = "kill";
            "${mod}+f" = "fullscreen toggle";
            "${mod}+Left" = "focus left";
            "${mod}+Down" = "focus down";
            "${mod}+Up" = "focus up";
            "${mod}+Right" = "focus right";
            "${mod}+Shift+Left" = "move left";
            "${mod}+Shift+Down" = "move down";
            "${mod}+Shift+Up" = "move up";
            "${mod}+Shift+Right" = "move right";

            # Tiling
            "${mod}+h" = "split h";
            "${mod}+v" = "split v";
            "${mod}+s" = "layout stacking";
            "${mod}+w" = "layout tabbed";
            "${mod}+e" = "layout toggle split";
            "${mod}+Shift+space" = "floating toggle";
            "${mod}+space" = "focus mode_toggle";
            "${mod}+a" = "focus parent";

            # Workspaces
            "${mod}+1" = "workspace ${ws1}";
            "${mod}+2" = "workspace ${ws2}";
            "${mod}+3" = "workspace ${ws3}";
            "${mod}+4" = "workspace ${ws4}";
            "${mod}+5" = "workspace ${ws5}";
            "${mod}+6" = "workspace ${ws6}";
            "${mod}+7" = "workspace ${ws7}";
            "${mod}+8" = "workspace ${ws8}";
            "${mod}+9" = "workspace ${ws9}";
            "${mod}+0" = "workspace ${ws10}";

            # Move windows
            "${mod}+Shift+1" = "move container to workspace ${ws1}; workspace ${ws1}";
            "${mod}+Shift+2" = "move container to workspace ${ws2}; workspace ${ws2}";
            "${mod}+Shift+3" = "move container to workspace ${ws3}; workspace ${ws3}";
            "${mod}+Shift+4" = "move container to workspace ${ws4}; workspace ${ws4}";
            "${mod}+Shift+5" = "move container to workspace ${ws5}; workspace ${ws5}";
            "${mod}+Shift+6" = "move container to workspace ${ws6}; workspace ${ws6}";
            "${mod}+Shift+7" = "move container to workspace ${ws7}; workspace ${ws7}";
            "${mod}+Shift+8" = "move container to workspace ${ws8}; workspace ${ws8}";
            "${mod}+Shift+9" = "move container to workspace ${ws9}; workspace ${ws9}";
            "${mod}+Shift+0" = "move container to workspace ${ws10}; workspace ${ws10}";

            # Resizing
            "${mod}+r" = ''mode "resize"'';
            "${mod}+Control+Shift+Left" = "resize shrink width 10 px or 10 ppt";
            "${mod}+Control+Shift+Right" = "resize grow height 10 px or 10 ppt";
            "${mod}+Control+Shift+Down" = "resize shrink height 10 px or 10 ppt";
            "${mod}+Control+Shift+Up" = "resize grow width 10 px or 10 ppt";
          };
          window = {
            border = 0;
            hideEdgeBorders = "smart";
            titlebar = false;
          };
          gaps = {
            inner = 20;
            outer = 0;
          };
          startup = [
            # Polybar
            {
              command = "systemctl --user restart polybar.service";
              always = true;
              notification = false;
            }
            # PyWal
            {
              command = "wal -R";
              notification = false;
            }
          ];
        };
    };
  };
}
