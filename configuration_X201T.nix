{ config, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  boot = {
	loader.grub.enable = true;
	loader.grub.device = "/dev/sda";
	kernelPackages = pkgs.linuxPackages_zen;
};
  networking = {
	hostName = "nixos";
	networkmanager.enable = true;
	nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
};
  time.timeZone = "Asia/Krasnoyarsk";
  i18n = {
	defaultLocale = "en_US.UTF-8";
	extraLocaleSettings = {
		LC_TIME = "ru_RU.UTF-8";
	};
};
  services = {
	xserver.enable = true;
	displayManager.ly = {
	enable = true;
	};
	gnome.gnome-keyring.enable = true;
	udisks2.enable = true;
	xserver.xkb = {
		layout = "us";
		variant= "";
	};
	pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
   	};
	mullvad-vpn.enable = true;
	mullvad-vpn.package = pkgs.mullvad;
	zapret = {
		enable = false;
		sf_presets = {
			enable = true;
			preset = "renixos";
		};
	};
	resolved = {
  		enable = true;
  		dnssec = "true";
  		domains = [ "~." ];
  		fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  		dnsovertls = "true";
	};
	cloudflare-warp.enable = true;
	tlp.enable = true;
	dbus.enable = true;
};
 programs = {
	sway.enable = true;
	steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true; 
		localNetworkGameTransfers.openFirewall = true;
	};
	adb.enable = true;
}; 
 hardware = {
	graphics = {
		enable = true;
		enable32Bit = true;
	};
	bluetooth.enable = true;
};
  security.rtkit.enable = true;
  users.users.frexia = {
    isNormalUser = true;
    description = "Frexia";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    packages = with pkgs; [
    ];
  };
  nix = {
	gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 5d";
	};
	settings.experimental-features = [ "nix-command" "flakes" ];
};
  system.autoUpgrade = {
	enable = true;
	allowReboot = false;
};
  nixpkgs.config = {
	allowUnfree = true;
};
  fonts.packages = with pkgs; [ nerd-fonts._0xproto nerd-fonts.droid-sans-mono ];
  environment = {
	systemPackages = with pkgs; [
		#APPS AND TOOLS
		dconf
		ffmpeg
		nh
		cloudflare-warp
		pamixer # for sway-bar volume
		playerctl # for sway-bar media
		pulseaudio # because I need pactl
		jq
	];
};
system.stateVersion = "25.05";
}
