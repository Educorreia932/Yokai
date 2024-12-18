{ user, ... }:

{
  home-manager.users.${user} = {
    home.file."firefox-gnome-theme" = {
      target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
      source = (
        fetchTarball "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/master.tar.gz"
      );
    };

    programs.firefox = {
      enable = true;
      profiles.default = {
        name = "Default";
        settings = {
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

          # For Firefox GNOME theme:
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.tabs.drawInTitlebar" = true;
          "svg.context-properties.content.enabled" = true;
        };
        userChrome = ''
          
                    @import "firefox-gnome-theme/userChrome.css";
                    @import "firefox-gnome-theme/theme/colors/dark.css"; 
        '';
      };
    };
  };
}
