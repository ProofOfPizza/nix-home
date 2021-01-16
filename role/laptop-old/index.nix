{ config, lib, pkgs, attrsets, ... }:
{
  imports = [
    ../../program/editor/neovim/default.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    dunst
    zathura
    libreoffice
    firefox-esr
    brave
    pulseaudio
    pulsemixer
    vlc
    chromium
    azuredatastudio
    keepass
    nodejs-14_x
    signal-desktop
    slack
    zoom
    teams
    stellarium
    mongodb-compass
    inotify-tools
    jq
    yq
    fzf
    ripgrep
    vifm
    alacritty
    zsh
    oh-my-zsh
    zsh-powerlevel10k
  ];


  # Zsh Shell
  programs.zsh = import ../../program/shell/zsh/default.nix;

  # Environment
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  programs.alacritty = {
    enable = true;
    settings = lib.attrsets.recursiveUpdate (import ../../program/terminal/alacritty/default-settings.nix) {
      background_opacity = 0.85;
      font.size = 11;
      font.user_thin_strokes = false;
      window = {
        decorations = "full";
      };
    };
  };


  xdg.configFile = {
    "dunst/dunstrc".source = ../../de/notifications/dunst/dunstrc;
    "~/.zshrc".source = ../../program/shell/zsh/.zshrc;
  };
}
