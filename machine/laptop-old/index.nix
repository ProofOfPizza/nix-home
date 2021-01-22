{ config, lib, pkgs, attrsets, ... }:
let coc = import ../../program/editor/neovim/coc.nix;
    keeweb = pkgs.callPackage ../../program/custom-built/keeweb/keeweb.nix {};
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
    direnv
    dunst
    feh
    firefox-esr
    flameshot
    fzf
    htop
    inotify-tools
    jq
    keen4
    keeweb
    keepass
    libreoffice
    lorri
    mongodb-compass
    neofetch
    nextcloud-client
    oh-my-zsh
    pulseaudio
    pulsemixer
    qtkeychain
    ripgrep
    signal-desktop
    slack
    stellarium
    teams
    transmission-gtk
    unzip
    vifm
    vivaldi
    vivaldi-ffmpeg-codecs
    vivaldi-widevine
    vlc
    whois
    xdotool #for autotype
    yq
    zathura
    zoom-us
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
      font.size = 12;
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

  home.file = {
    ".config/nvim/colors/SpaceMacs.vim".source = ../../program/editor/neovim/configs/SpaceMacs.vim;
    ".config/nvim/coc-settings.json".source = ../../program/editor/neovim/configs/coc-settings.json;
    ".config/nvim/.prettierrc".source = ../../program/editor/neovim/configs/.prettierrc;
    ".config/nvim/eslintrc.json".source = ../../program/editor/neovim/configs/eslintrc.json;
    ".config/i3/config".source = ../../program/window-manager/i3/config;
    ".config/i3/i3switch".source = ../../program/window-manager/i3/python-switch-script/result/bin/i3switch;
    ".config/i3/xrandr-2.sh".source = ../../program/window-manager/i3/xrandr-2.sh;
  };
  xdg.configFile = {
    "dunst/dunstrc".source = ../../de/notifications/dunst/dunstrc;
  };
  services.lorri.enable = true;
}
