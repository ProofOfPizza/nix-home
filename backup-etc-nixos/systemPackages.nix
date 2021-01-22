# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ];
  environment.systemPackages = with pkgs;  [
    alacritty
    arandr
    bash
    dmenu
    docker
    gitAndTools.gitFull
    gnome3.libgnome-keyring
    home-manager
    htop
    libsecret
    nano
    niv
    rxvt_unicode
    tree
    udiskie
    vifm
    wget
    xclip
    xorg.xrandr
  ];
}

