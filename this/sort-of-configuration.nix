
{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./programs/file-manager/vifm/default.nix
    ./programs/terminal/alacritty/default.nix  # Include Alacritty config
    ./programs/git/git/default.nix
    ./programs/editor/neovim/default.nix
    ./programs/shell/zsh/default.nix
    # other imports...
  ];

  home.file = {
    "~/.config/nvim/colors/SpaceMacs.vim".source = ./program/editor/neovim/configs/SpaceMacs.vim;
    "~/.config/nvim/coc-settings.json".source = ./program/editor/neovim/configs/coc-settings.json;
    "~/eslintrc.js".source = ./program/editor/neovim/configs/eslintrc.js;
    "~/.config/i3/config".source = ./program/window-manager/i3/config;
    "~/.config/i3/xrandr-2.sh".source = ./program/window-manager/i3/xrandr-2.sh;
    "~/.config/i3/xrandr-1.sh".source = ./program/window-manager/i3/xrandr-1.sh;
    "~/.config/i3/xrandr-1920.sh".source = ./program/window-manager/i3/xrandr-1920.sh;
    "~/.dmenurc".source = ../../program/window-manager/i3/.dmenurc;
  };

  services.lorri.enable = true;
  # Environment variables and packages
  environment.systemPackages = with pkgs; [
    # List your system packages here
    alacritty
    vifm
    # ... other packages
  ];

  # X server and window manager configuration
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:swapescape";
    windowManager.i3.enable = true;
    displayManager.lightdm.enable = true;
  };

  # Other system configurations...
}
