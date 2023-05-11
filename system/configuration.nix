# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-fb42e276-3522-4b2e-85be-75cb8c1f02e0".device = "/dev/disk/by-uuid/fb42e276-3522-4b2e-85be-75cb8c1f02e0";
  boot.initrd.luks.devices."luks-fb42e276-3522-4b2e-85be-75cb8c1f02e0".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.wireless.interfaces = [ "wlp2s0" ];


  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chai = {
    isNormalUser = true;
    description = "chai stofkoper";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  location.latitude = 51.92;
  location.longitude = 4.47;

  services = {
    fstrim.enable = true;
    openssh.enable = true;
    printing.enable = true;
    redshift = {
        enable = true;
        temperature.day = 5700;
        temperature.night = 3000;
        };
    gnome.gnome-keyring.enable = true;
  };

  virtualisation = {
    docker.enable = true;
    docker.enableOnBoot = true;
  };

  environment.shells = [ pkgs.zsh pkgs.bash ];
  programs.vim.defaultEditor = true;
  fonts.fonts = [ pkgs.powerline-fonts ];
  fonts.fontDir.enable = true;
  fonts.enableDefaultFonts = true;
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts.monospace = [ "Inconsolata-g for Powerline:h12" ];
  console.font =  "Meslo for Powerline:h12";

  sound.enable = true;

  hardware = {
      pulseaudio = {
          enable = true;
          package = pkgs.pulseaudioFull;
          # extraModules = [ pkgs.pulseaudio-modules-bt ];
      };
  };

 environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

 # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
unzip
   firefox
  #  wget
  ];

  networking.wg-quick.interfaces = {
    wg-firewalla = {
      address = [ "10.200.149.4/32" ];
      listenPort = 51820;
      dns = [ "10.200.149.1" ];
      mtu = 1412;
      privateKeyFile = "/etc/wireguard/keys/firewalla-private";
      peers = [
        {
          publicKey = "3xUCRZNLFaAtwpVtLQXER+t4INT87AjmR9e6Z7vJ6nM=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "dm2lm0tqnlo.d.firewalla.org:51820";
          persistentKeepalive = 25;
        }
      ];
    };
    #wg-mullvad-nl = {
    #  #mullvad-nl20
    #  address = [ "10.67.157.84/32" "fc00:bbbb:bbbb:bb01::4:9d53/128" ];
    #  dns = [ "193.138.218.74" ]; # mullvad public dns
    #  privateKeyFile = "/etc/wireguard/keys/mullvad-nl20-private";
    #  peers = [
    #    {
    #      publicKey = "StMPmol1+QQQQCJyAkm7t+l/QYTKe5CzXUhw0I6VX14=";
    #      allowedIPs = [ "0.0.0.0/0" "::0/0" ];
    #      endpoint = "92.60.40.194:51820";
    #    }
    #  ];
    #};
    wg-mullvad-nl = {
      #mullvad-nl-5
      address = [ "10.67.157.84/32" "fc00:bbbb:bbbb:bb01::4:9d53/128" ];
      dns = [ "193.138.218.74" ]; # mullvad public dns
      privateKeyFile = "/etc/wireguard/keys/mullvad-nl5-private";
      peers = [
        {
          publicKey = "33BoONMGCm2vknq2eq72eozRsHmHQY6ZHEEZ4851TkY=";
          allowedIPs = [ "0.0.0.0/0" "::0/0" ];
          endpoint = "193.32.249.70:51820";
        }
      ];
    };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
