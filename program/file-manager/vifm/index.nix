{ config, lib, pkgs, ... }:
{
  xdg.configFile."vifm/vifmrc".source = ./vifmrc;
}
