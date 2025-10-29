{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    
    settings = {

      logo = {
	source = "nixos";
        type = "auto";
	color = {
        "1" = "#cc99ff";
        "2" = "#bf00ff";
      };
    };

      modules = [
	"break"
        "title"
        "separator"
        "os"
        "kernel"
        "packages"
	"font"
        "display"
        "terminal"
	"lm"
        "wm"
	"bios"
        "cpu"
	"cpucache"
        "gpu"
	"opengl"
        "memory"
	"swap"
        "disk"
        "uptime"
	"battery"
	"colors"
      ];
    };
  };
}
