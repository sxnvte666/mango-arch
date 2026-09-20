{ pkgs, ... }:

{
  home.packages = [
    pkgs.pfetch
    (pkgs.catppuccin-gtk.override {
    	accents = [ "pink" ];
	    size = "standard";
	    variant = "macchiato";
    })
    (pkgs.catppuccin-papirus-folders.override {
	    flavor = "macchiato";
	    accent = "pink";
    })
  ];
}
