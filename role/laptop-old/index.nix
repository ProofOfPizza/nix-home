{ config, lib, pkgs, attrsets, ... }:
let coc = import ../../program/editor/neovim/coc.nix;
in
{
  imports = [
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    alacritty
    azuredatastudio
    brave
    chromium
    dunst
    firefox-esr
    fzf
    htop
    inotify-tools
    jq
    keepass
    libreoffice
    mongodb-compass
    neofetch
    nodejs-14_x
    oh-my-zsh
    pulseaudio
    pulsemixer
    ripgrep
    signal-desktop
    slack
    stellarium
    teams
    thefuck
    vifm
    vivaldi
    vivaldi-widevine
    vivaldi-ffmpeg-codecs
    vlc
    whois
    yarn
    yq
    zathura
    zoom
    zsh
  ];

  # neovim
  programs.neovim = import ../../program/editor/neovim/default.nix;

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

  # Git
  programs.git = {
    enable = true;
    userEmail = "laagislaag@gmail.com";
    userName = "ProofOfPizza";
#    signing.key = "";
#    signing.signByDefault = true;
    extraConfig = {
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };

  home.file.".config/nvim/colors/SpaceMacs.vim".source = ../../program/editor/neovim/SpaceMacs.vim;
  xdg.configFile = {
    "dunst/dunstrc".source = ../../de/notifications/dunst/dunstrc;
    "nvim/coc-settings.json".source =
      builtins.toFile "coc-settings.json" (builtins.toJSON (coc { config = config; }));
  };
}
