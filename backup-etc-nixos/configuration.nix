# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./systemPackages.nix
      ./i3.nix
    ];

  # Use the GRUB 2 boot loader.
  #boot.loader.grub.enable = true;
  #boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  #boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
#grub
  boot.loader.grub = {
    enable = true;
    version = 2;
    efiSupport = false;
    enableCryptodisk = true;
   # device = "/dev/disk/by-uuid/651cea7f-5d8c-48fe-9c3f-7f23189aa501";
    device = "/dev/sda";
    useOSProber = true;
    };
   # luks
  boot.initrd.luks.devices = {
    luksroot = {
      device = "/dev/disk/by-uuid/3ffa2e33-93c3-4e11-8d09-790a965079bc";
      preLVM = true;
      allowDiscards = true;
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
    xserver.libinput.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    printing.enable = true;

    redshift = {
      enable= true;
      temperature.day = 5700;
      temperature.night = 3000;
    };
  };

  virtualisation = {
    docker.enable = true;
    docker.enableOnBoot = true;
  };

  environment.shells = [ pkgs.zsh pkgs.bash ];
  programs.thefuck.enable = true;
  programs.vim.defaultEditor = true;

  fonts.fonts = [ pkgs.powerline-fonts ];
  fonts.enableFontDir = true;
  fonts.enableDefaultFonts = true;
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts.monospace = [ "Inconsolata-g for Powerline:h15" ];
  console.font = "Meslo for  Powerline:h16";

  time.timeZone = "Europe/Amsterdam";

  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the GNOME 3 Desktop Environment.
###  services.xserver.enable = true;
###  services.xserver.displayManager.gdm.enable = true;
###  services.xserver.desktopManager.gnome3.enable = true;


  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.extraUsers.chai = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    uid = 1000;
    createHome = true;
    hashedPassword = "$6$XZiV7Wrf$iWgXELwcwrxmBV07MpvANheHEiHAz5PYfacGqH3fqsJIOrFYRV35kJT2tPPiGZFfMizN8rBph693JCYgvOS6a1";
    home = "/home/chai";
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  #   firefox
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


# from other sources:
 nixpkgs.config.allowUnfree = true;

environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
        defaultSession = "none+i3";
    };
  };
  #  windowManager.i3 = import ./i3.nix;
#
#    windowManager.i3 = {
#      enable = true;
#      package = pkgs.i3-gaps;
#      extraPackages = with pkgs; [
#        dmenu #application launcher most people use
#        i3status # gives you the default i3 status bar
#        i3lock #default i3 screen locker
#        i3blocks #if you are planning on using i3blocks over i3status
#     ];
#    };
#  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

