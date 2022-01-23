{ config, lib, pkgs ? import <unstable> {}, attrsets, ... }:
let coc = import ../../program/editor/neovim/coc.nix;
    keeweb = pkgs.callPackage ../../program/custom-built/keeweb/keeweb.nix {};
    # exodus = pkgs.callPackage ../../program/custom-built/exodus/exodus.nix {};
in
{
  imports = [
  ../../program/file-manager/vifm/index.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    alacritty
    azuredatastudio
    brave
    chromium
    dig
    direnv
    docker
    docker-compose
    # docker-credential-helpers
    dunst
    element-desktop
    evince
    exodus
    feh
    firefox
    flameshot
    fzf
    gnupg
    htop
    inotify-tools
    jq
    jwt-cli
    keen4
    keeweb
    keepass
    kpcli
    libreoffice
    lorri
    lsof
    monero
    mysql-workbench
    nextcloud-client
    nmap
    nvme-cli
    oh-my-zsh
    pulseaudio
    pulsemixer
    libsForQt5.qtkeychain
    p7zip
    peek
    postman
    ripgrep
    rox-filer
    signal-desktop
    slack
    spotify
    steam
    stellarium
    teams
    transmission-gtk
    unzip
    viewnior
    vifm
    vivaldi
    vivaldi-ffmpeg-codecs
    vivaldi-widevine
    vlc
    whois
    xarchiver
    xmrig
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
      font.size = 10;
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
    pull.rebase = true;
    fetch.prune = true;
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
    # ".prettierrc".source = ../../program/editor/neovim/configs/.prettierrc;
    # ".stylelintrc".source = ../../program/editor/neovim/configs/.stylelintrc;
    "eslintrc.js".source = ../../program/editor/neovim/configs/eslintrc.js;
    ".config/i3/config".source = ../../program/window-manager/i3/config;
 #   ".config/i3/i3switch".source = ../../program/window-manager/i3/python-switch-script/result/bin/i3switch;
    ".config/i3/xrandr-2.sh".source = ../../program/window-manager/i3/xrandr-2.sh;
    ".config/i3/xrandr-1.sh".source = ../../program/window-manager/i3/xrandr-1.sh;
    ".config/i3/xrandr-1920.sh".source = ../../program/window-manager/i3/xrandr-1920.sh;
    ".dmenurc".source = ../../program/window-manager/i3/.dmenurc;
  };
  xdg.configFile = {
    "dunst/dunstrc".source = ../../de/notifications/dunst/dunstrc;
  };
  services.lorri.enable = true;
}
