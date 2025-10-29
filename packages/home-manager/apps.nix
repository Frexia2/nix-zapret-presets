{ config, pkgs, ... }:
{

home.packages = with pkgs; [
	abaddon
	ani-cli
	btop
	deadbeef
	feh
	git
	kew
	libreoffice-fresh
	mate.engrampa
	nemo
	obsidian
	scrcpy
	tg
	vim
	vlc
	qbittorrent
	telegram-desktop
	signal-desktop
	grim
	slurp
	quakespasm
	wl-clipboard
	wf-recorder
	wmenu
	wine-staging
	winetricks
];

}
