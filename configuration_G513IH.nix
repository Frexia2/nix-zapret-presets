{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
boot = {
  loader.grub.enable = true;
  loader.grub.device = "nodev";
  loader.grub.useOSProber = true;
  loader.grub.efiSupport = true;

  loader.efi.canTouchEfiVariables = true;
  loader.efi.efiSysMountPoint = "/boot";

  kernelPackages = pkgs.linuxPackages_zen;
  kernelParams = [ "nvidia-drm.modeset=1" ];
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
		LC_ADDRESS = "ru_RU.UTF-8";
		LC_IDENTIFICATION = "ru_RU.UTF-8";
		LC_MEASUREMENT = "ru_RU.UTF-8";
		LC_MONETARY = "ru_RU.UTF-8";
		LC_NAME = "ru_RU.UTF-8";
		LC_NUMERIC = "ru_RU.UTF-8";
		LC_PAPER = "ru_RU.UTF-8";
		LC_TELEPHONE = "ru_RU.UTF-8";
		LC_TIME = "ru_RU.UTF-8";
  };
};

services = {
	xserver.enable = true;
	displayManager.ly = {
		enable = true;
	};
	desktopManager.plasma6.enable = true;  
	xserver.xkb = {
	layout = "us";
	variant = "";
	};
	mullvad-vpn.enable = true;
	mullvad-vpn.package = pkgs.mullvad;
	flatpak.enable = true;
	gvfs.enable = true;
	cloudflare-warp.enable = true;
	resolved = {
		enable = true;
		dnssec = "true";
		domains = [ "~." ];
		fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
		dnsovertls = "true";
	};
	xserver.videoDrivers = [
	"amdgpu"
	"nvidia"
	];
	zapret = {
		enable = false;
		sf_presets = {
		enable = true;
		preset = "renixos";
     		};
   	};
	pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};
};

hardware = {
	graphics = {
		enable = true;
		extraPackages = with pkgs; [
			mesa.opencl
		];
	};
	nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
		prime = {
			offload = {
				enable = true;
				enableOffloadCmd = true;
				};
			nvidiaBusId = "PCI:1:0:0";
			amdgpuBusId = "PCI:6:0:0";
		};
	};
};

  security.rtkit.enable = true;

  users.users.frexia = {
    isNormalUser = true;
    description = "Frexia";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    packages = with pkgs; [
    ];
  };

programs = {
	firefox.enable = true;
	steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true; 
		localNetworkGameTransfers.openFirewall = true;
		extraCompatPackages = with pkgs; [
   			 proton-ge-bin
  		];
	};
	adb.enable = true;
};

nix = {
	gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 5d";
	};
	settings.experimental-features = [ "nix-command" "flakes" ];
};

system = {
	autoUpgrade.enable = true;
	autoUpgrade.allowReboot = false;
};

  nixpkgs.config.allowUnfree = true;
	
environment = {
	systemPackages = with pkgs; [
		#APPS AND TOOLS
		ani-cli
		btop
		deadbeef
		fastfetch
		ffmpeg
		filezilla
		foot
		git
		keepassxc
		kew
		kdePackages.kdenlive
		libreoffice-fresh
		nemo
		nh
		obs-studio
		obsidian
		scrcpy
		vim
		vlc
		qbittorrent
		rofi
		#BYPASS CENSORSHIP
		cloudflare-warp
		#CUSTOMIZATION
		bibata-cursors
		kurve
		#DEPENDENCIES
		jmtpfs
		glib
		unrar
		#MESSAGING AND SOCIALS
		discord
		signal-desktop
		telegram-desktop
		#WINE
		wine-staging
		winetricks
	];
	plasma6.excludePackages = with pkgs; [
		kdePackages.kdepim-runtime
		kdePackages.kmahjongg
		kdePackages.kmines
		kdePackages.konversation
		kdePackages.kpat
		kdePackages.ksudoku
		kdePackages.ktorrent
		kdePackages.kcalc
		kdePackages.isoimagewriter
		kdePackages.kolourpaint
		kdePackages.dolphin
		kdePackages.konsole
	];
	variables = {
		RUSTICL_ENABLE = "radeonsi";
	};
};
  system.stateVersion = "25.05"; # Did you read the comment?
}
