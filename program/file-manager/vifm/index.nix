{ config, lib, pkgs, ... }:
  {
    home.file = {
    ".vifm/vifmrc".source = ./vifmrc;
    # get the colors from git: git clone https://github.com/vifm/vifm-colors ~/.config/vifm/colors
  };
}
