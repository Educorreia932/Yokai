{ lib, pkgs, ... }:

{
    fonts = {
		enableDefaultPackages = false;
		fontDir.enable = true;

		packages = with pkgs; [
			material-design-icons
			meslo-lg
			noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-cjk-serif
			noto-fonts-emoji
			ubuntu_font_family
			unifont
		];

		fontconfig = {
			antialias = true;
			localConf = lib.fileContents ./fontconfig.xml;
			defaultFonts = {
				serif = [ "Ubuntu" "Noto Serif" "Noto Serif CJK JP"];
				sansSerif = [ "Ubuntu" "Noto Sans" "Noto Sans CJK JP" ];
				monospace = [ "Meslo LG M" "Ubuntu Source" "Noto Sans Mono" ];
				emoji = [ "Noto Color Emoji" ];
			};
		};
	};
}
