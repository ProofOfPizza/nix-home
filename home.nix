{ config, pkgs, ... }:

{
  # Let home manager mange itself
  programs.home-manager.enable = true;
  
  home.stateVersion = "22.11";
  home.username = "chai";
  home.homeDirectory = "/home/chai";
  imports = [
    ./machine/laptop-old/index.nix
  ];
}
