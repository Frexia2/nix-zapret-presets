{ pkgs, ... }:

{

gtk = {
	enable = true;
	iconTheme = {
	name = "rose-pine";
	package = pkgs.rose-pine-icon-theme;
    };
	cursorTheme = {
		name = "Bibata-Modern-Classic";
		package = pkgs.bibata-cursors;
    };
	theme = {
		name = "rose-pine";
		package = pkgs.rose-pine-gtk-theme;
    };
};

qt = {
	enable = true;
	platformTheme.name = "gtk";
};

home = {
	packages = with pkgs; [
		gtk-engine-murrine
		];
};

}
