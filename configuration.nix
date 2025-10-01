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

  # Enable the Cinnamon Desktop Environment.
  services.displayManager.ly = {
	enable = true;
  };
  services.xserver.desktopManager.cinnamon.enable = true;  
 
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  # Enable sound with pipewire.
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

  # Zapret (kill me)
  services.zapret = {
    enable = false;
    sf_presets = {
      enable = false;
      preset = "renixos";
    };
  };

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

  # Install firefox.
  programs.firefox.enable = true;

  # Getting Steam
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow ADB
  programs.adb.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    abaddon
    # discord
    deadbeef
    filezilla
    openvpn3
    telegram-desktop
    fastfetch
    scrcpy
    signal-desktop
    vim
    vlc
    qbittorrent
    ani-cli
    keepassxc
    obsidian
    nh
    btop
    mate.engrampa
    git
    libreoffice-fresh
   # wine-staging (version with experimental features)
   wineWowPackages.staging
   
   # winetricks (all versions)
   winetricks
  ];
  system.stateVersion = "25.05"; # Did you read the comment?

}
