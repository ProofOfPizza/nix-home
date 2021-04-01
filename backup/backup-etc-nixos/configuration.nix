# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./systemPackages.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
    luksroot = {
      device = "/dev/disk/by-uuid/bd52360c-b250-4b45-b083-380b3488f260";
      preLVM = true;
      };
  };

  # networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
hardware.opengl.driSupport32Bit = true;
  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;
  time.timeZone = "Europe/Amsterdam";
  #networking.networkmanager.enable = true;


  services.xserver = {
    enable = true;
    libinput.enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
  };

  systemd.user.services."dunst" = {
    enable = true;
    wantedBy = [ "default.target" ];
    serviceConfig.Restart = "always";
    serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
};

    location.latitude = 51.92;
    location.longitude = 4.47;

  services = {

    # Enable touchpad support (enabled default in most desktopManager).

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    printing.enable = true;

    redshift = {
      enable= true;
      temperature.day = 5700;
      temperature.night = 3000;
    };
    gnome3.gnome-keyring.enable = true;
  };

  virtualisation = {
    docker.enable = true;
    docker.enableOnBoot = true;
  };

  environment.shells = [ pkgs.zsh pkgs.bash ];
  programs.vim.defaultEditor = true;

  fonts.fonts = [ pkgs.powerline-fonts ];
  fonts.enableFontDir = true;
  fonts.enableDefaultFonts = true;
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts.monospace = [ "Inconsolata-g for Powerline:h12" ];
  console.font = "Meslo for  Powerline:h12";

  sound.enable = true;
  hardware.pulseaudio.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = true;
  users.extraUsers.chai = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    uid = 1000;
    createHome = true;
    hashedPassword = "$6$XZiV7Wrf$iWgXELwcwrxmBV07MpvANheHEiHAz5PYfacGqH3fqsJIOrFYRV35kJT2tPPiGZFfMizN8rBph693JCYgvOS6a1";
    home = "/home/chai";
    shell = pkgs.zsh;
  };

 nixpkgs.config.allowUnfree = true;

environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

