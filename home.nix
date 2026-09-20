{ pkgs, ... }:

{
  imports = [ ./packages.nix ];

  home.username = "sx";
  home.homeDirectory = "/home/sx";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "JetBrainsMono Nerd Font" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };

  dconf.settings = {
  	"org/gnome/desktop/interface" = {
		color-scheme = "prefer-dark";
		gtk-theme = "catppuccin-macchiato-pink-standard";
		icon-theme = "Papirus-Dark";
		};
  };

  qt = {
    enable = true;
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  home.file = {
    ".config/foot".source = ./config/foot;
    ".config/waybar".source = ./config/waybar;
    ".config/mango".source = ./config/mango;
    ".config/rofi".source = ./config/rofi;
  };

}
