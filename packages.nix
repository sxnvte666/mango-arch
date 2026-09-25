{ pkgs, ... }:

{
  home.packages = [
    (pkgs.catppuccin-gtk.override {
    	accents = [ "green" ];
	    size = "standard";
	    variant = "mocha";
    })
    (pkgs.catppuccin-papirus-folders.override {
	    flavor = "mocha";
	    accent = "green";
    })
  ];
}
