{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

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
  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
}; 

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

 hardware.graphics = {
	enable = true;
	enable32Bit = true;
};
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
   };

  users.users.frexia = {
    isNormalUser = true;
    description = "Frexia";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    packages = with pkgs; [
    ];
  };

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad;

  # Zapret (kill me)
  services.zapret = {
    enable = true;
    sf_presets = {
      enable = true;
      preset = "renixos";
    };
  };

  services.cloudflare-warp.enable = true;
  services.tlp.enable = true;
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
};

  nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 5d";
};

nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  home-manager = {
	users = {
	"frexia" = import ./home.nix;
	};
};

  nixpkgs.config.allowUnfree = true;

  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    #APPS AND TOOLS
    abaddon
    ani-cli
    btop
    fastfetch
    ffmpeg
    filezilla
    git
    keepassxc
    kew
    libreoffice-fresh
    mate.engrampa
    nemo
    nh
    obsidian
    scrcpy
    vim
    vlc
    qbittorrent
    #BYPASSING CENSORSHIP
    cloudflare-warp
    #CUSTOMIZATION
    bibata-cursors
    dconf
    dconf-editor
    lxappearance
    mint-x-icons
    themix-gui
    #DEPENDENCIES
    pamixer # for sway-bar volume
    jq # sorting algorithm
    #MESSAGING AND SOCIALS
    telegram-desktop
    signal-desktop
    #SWAY
    grim
    slurp
    wl-clipboard
    mako
    #WINE
    wine-staging
    winetricks
  ];

  system.stateVersion = "25.05";

}
