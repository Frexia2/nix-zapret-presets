{ config, pkgs, lib, ... }:

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
	platformTheme ={
		name = "qt6ct";
	};
	style.name = "kvantum";
};

xdg.configFile = {
"Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=rose-pine-iris
    
    [Applications]
    "*"=rose-pine-iris
  '';

  "Kvantum/rose-pine-iris".source = "${pkgs.rose-pine-kvantum}/share/Kvantum/themes/rose-pine-iris";
};

home = {
	packages = with pkgs; [
		gtk-engine-murrine
		qt6Packages.qtstyleplugin-kvantum
		kdePackages.qt6ct
	];
};

}
