{ pkgs, ... }:

{
  home-manager.users.eduardo = {
    services.polybar = {
      enable = true;

      package = pkgs.polybar.override {
        i3Support = true;
        alsaSupport = true;
        iwSupport = true;
        githubSupport = true;
      };

      config =
        let
          color = {
            background = "#050104";
            foreground = "#E0E3C8";
            foreground-alt = "#9C9E8C";
            module-fg = "#E0E3C8";
            primary = "#E0E3C8";
            secondary = "#B62813";
            alternate = "#B62813";
          };
        in
        {
          "bar/main" = {
            bottom = true;
            height = 40;
            line-size = 2;
            module-margin-left = 1;
            module-margin-right = 1;
            enable-ipc = true;
            radius = 5;
            tray-background = color.background;

            # Borders
            border-color = "#00000000";
            border-bottom-size = 20;
            border-left-size = 20;
            border-right-size = 20;

            # Fonts
            font-0 = "Meslo LG M:pixelsize=13;4";
            font-1 = "Material Design Icons:style=Regular:size=16;4";
            font-2 = "Font Awesome:style=Regular:pixelsize=13;4";
            font-3 = "Noto Serif CJK JP:style=Regular:size=16;4";

            # Modules
            modules-left = "i3";
            modules-right = "date network battery powermenu";
          };

          "module/temperature" = {
            type = "internal/temperature";
            label = "%{T3}󰔏 %{T-}%temperature-c%";
          };

          "module/powermenu" = {
            type = "custom/menu";

            expand-right = true;

            format-spacing = 1;
            format-padding = 1;

            label-open = " 󰐥 ";
            label-close = " 󰅖 ";
            label-open-foreground = color.background;
            label-open-background = color.foreground;
            label-close-foreground = color.background;
            label-close-background = color.foreground;
            label-separator = "|";

            menu-0-0 = "󰍁";
            menu-0-0-exec = "i3lock";
            menu-0-1 = "󰤄";
            menu-0-1-exec = "suspend";
            menu-0-2 = "󰁪";
            menu-0-2-exec = "reboot";
            menu-0-3 = "󰚦";
            menu-0-3-exec = "poweroff";
          };

          "module/network" = {
            type = "internal/network";
            interface = "wlo1";
            accumulate-stats = true;
            unknown-as-up = true;
            format-connected = "<ramp-signal> <label-connected>";
            format-disconnected-prefix = "";
            label-connected = "%essid%";
            label-disconnected = "\${A1:networkmanager_dmenu &:} Offline%{A}";
            ramp-signal-0 = "󰤟";
            ramp-signal-1 = "󰤢";
            ramp-signal-2 = "󰤨";
          };

          "module/i3" = {
            type = "internal/i3";
            pin-workspaces = true;
            strip-wsnumbers = true;
            fuzzy-match = true;
            ws-icon-0 = "1;一";
            ws-icon-1 = "2;二";
            ws-icon-2 = "3;三";
            ws-icon-3 = "4;四";
            ws-icon-4 = "5;五";
            ws-icon-5 = "6;六";
            ws-icon-6 = "7;七";
            ws-icon-7 = "8;八";
            ws-icon-8 = "9;九";
            ws-icon-9 = "0;十";
            ws-icon-default = "";
            label-focused = "%icon%";
            label-focused-padding = 2;
            label-focused-foreground = color.background;
            label-focused-background = color.foreground;
            label-focused-underline = color.foreground-alt;
            label-unfocused = "%icon%";
            label-unfocused-padding = 2;
            label-unfocused-foreground = color.foreground-alt;
          };

          "module/date" = {
            type = "internal/date";
            interval = "1.0";
            time = "%H:%M";
            format = "<label>";
            format-prefix = "󱑎 ";
            label = "%time%";
          };

          "module/battery" = {
            type = "internal/battery";
            full-at = 99;
            battery = "BAT0";
            adapter = "AC0";
            format-charging = "<animation-charging> <label-charging>";
            format-discharging = "<ramp-capacity> <label-discharging>";
            format-full = "<label-full>";
            format-full-prefix = "󰁹";
            label-charging = "%percentage%%";
            label-discharging = "%percentage%%";
            label-full = " Full";
            ramp-capacity-0 = "󰁺";
            ramp-capacity-1 = "󰁻";
            ramp-capacity-2 = "󰁼";
            ramp-capacity-3 = "󰁽";
            ramp-capacity-4 = "󰁾";
            ramp-capacity-5 = "󰁿";
            ramp-capacity-6 = "󰂀";
            ramp-capacity-7 = "󰂁";
            ramp-capacity-8 = "󰂂";
            ramp-capacity-9 = "󰁹";
            animation-charging-0 = "󰂊";
            animation-charging-1 = "󰂋";
            animation-charging-framerate = 750;
          };
        };

      script = "polybar &";
    };
  };
}
