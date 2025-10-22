{ config, pkgs, ... }:

{
 xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["nemo.desktop"];
        "text/plain" = ["vim.desktop"];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["libreoffice.desktop"];
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = ["libreoffice.desktop"];
        "application/zip" = ["engrampa.desktop"];
        "text/*" = ["vim.desktop"];
        "video/*" = ["vlc.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/mailto" = ["firefox.desktop"];
        "image/*" = ["feh.desktop"];
        "image/png" = ["feh.desktop"];
        "image/jpeg" = ["feh.desktop"];
      };
    };
    portal = {
	enable = true;
	config = {
	common.default = ["wlr" "gtk"];
	sway.default = ["wlr" "gtk"];
	};
	extraPortals = with pkgs; [
	xdg-desktop-portal-gtk
	xdg-desktop-portal-wlr
	];
	};
  };
}
