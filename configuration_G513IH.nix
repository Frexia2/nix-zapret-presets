{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Krasnoyarsk";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  services.xserver.enable = true;

  services.displayManager.ly = {
	enable = true;
  };
  services.desktopManager.plasma6.enable = true;  
 
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
	mesa.opencl
	];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [
	"amdgpu"
	"nvidia"
];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia.prime = {
	offload = {
		enable = true;
		enableOffloadCmd = true;
		};

	nvidiaBusId = "PCI:1:0:0";
	amdgpuBusId = "PCI:6:0:0";
};


  services.printing.enable = true;
  services.gvfs.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
   };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.frexia = {
    isNormalUser = true;
    description = "Frexia";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    packages = with pkgs; [
    ];
  };

  # Install Mullvad VPN
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  # Zapret
     services.zapret = {
     enable = true;
     sf_presets = {
       enable = true;
       preset = "renixos";
     };
   };

  # Cloudflare WARP
  services.cloudflare-warp.enable = true;

  # Enabling Flatpak
  services.flatpak.enable = true;

  # Enabling systemd-resolved
  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

	services.resolved = {
  		enable = true;
  		dnssec = "true";
  		domains = [ "~." ];
  		fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  		dnsovertls = "true";
	};

  programs.firefox.enable = true;

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true;
  dedicatedServer.openFirewall = true; 
  localNetworkGameTransfers.openFirewall = true;
  extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
};
  # Enable AppImage
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # I don't care about your "philosophy", leave me alone
  programs.nix-ld.enable = true;

  # Clearing generations
  nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 5d";
};

nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto-upgrades
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  nixpkgs.config.allowUnfree = true;

  programs.adb.enable = true; 
 
  environment.systemPackages = with pkgs; [
    #APPS AND TOOLS
    ani-cli
    appimage-run
    btop
    fastfetch
    ffmpeg
    filezilla
    git
    keepassxc
    kew
    kdePackages.kdenlive
    kitty
    libreoffice-fresh
    nemo
    nh
    obs-studio
    obsidian
    scrcpy
    steam-run
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
    #EMULATORS
    pcsx2
    #MESSAGING AND SOCIALS
    discord
    signal-desktop
    telegram-desktop
    #WINE
    wineWowPackages.staging
    winetricks
  ];
 environment.plasma6.excludePackages = with pkgs; [
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
  environment.variables = {
	RUSTICL_ENABLE = "radeonsi";
	};
  system.stateVersion = "25.05"; # Did you read the comment?

}
