{ config, pkgs, ... }:
{

home.packages = with pkgs; [
	abaddon
	ani-cli
	btop
	fastfetch
	feh
	git
	keepassxc
	kew
	libreoffice-fresh
	mate.engrampa
	nemo
	obsidian
	scrcpy
	vim
	vlc
	qbittorrent
	telegram-desktop
	signal-desktop
	grim
	slurp
	wl-clipboard
	wmenu
	wine-staging
	winetricks
];

}
