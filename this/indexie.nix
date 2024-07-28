{ config, lib, pkgs ? import <unstable> {}, attrsets, ... }:
let coc = import ../../program/editor/neovim/coc.nix;
    keeweb = pkgs.callPackage ../../program/custom-built/keeweb/keeweb.nix {};
    # exodus = pkgs.callPackage ../../program/custom-built/exodus/exodus.nix {};
    # unstable = import <nixos-unstable> {};
    pkgs-unstable = import <pkgs-unstable> {};
    channel2211 = import <channel2211> {};
in
{
  imports = [
  ../../program/file-manager/vifm/index.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.alacritty
    pkgs-unstable.arandr
    pkgs-unstable.azuredatastudio
    pkgs-unstable.brave
    pkgs-unstable.chromium
    pkgs-unstable.dig
    pkgs-unstable.direnv
    pkgs-unstable.docker
    pkgs-unstable.docker-compose
    # docker-credential-helpers
    pkgs-unstable.element-desktop
    pkgs-unstable.evince
    # pkgs-unstable.exodus
    pkgs-unstable.feh
    pkgs-unstable.ffmpegthumbnailer
    pkgs-unstable.firefox
    pkgs-unstable.flameshot
    pkgs-unstable.fzf
    pkgs-unstable.gnupg
    pkgs-unstable.htop
    pkgs-unstable.inotify-tools
    pkgs-unstable.jetbrains.idea-community
    pkgs-unstable.jq
    pkgs-unstable.jwt-cli
    pkgs-unstable.keeweb
    pkgs-unstable.librewolf
    pkgs-unstable.libreoffice
    pkgs.lorri
    pkgs-unstable.lsof
    pkgs-unstable.mcomix3
    pkgs-unstable.monero
    pkgs-unstable.nextcloud-client
    pkgs-unstable.nmap
    pkgs-unstable.nvme-cli
    pkgs.oh-my-zsh
    pkgs-unstable.pulseaudio
    pkgs-unstable.pulsemixer
    pkgs-unstable.libsForQt5.qtkeychain
    pkgs-unstable.p7zip
    pkgs-unstable.peek
    pkgs-unstable.poppler_utils
    pkgs-unstable.postman
    pkgs-unstable.ripgrep
    pkgs-unstable.screenkey
    pkgs-unstable.signal-desktop
    pkgs-unstable.slack
    pkgs-unstable.spotify
    pkgs-unstable.steam
    pkgs-unstable.stellarium
    pkgs-unstable.sublime3
    pkgs-unstable.traceroute
    pkgs-unstable.transmission-gtk
    pkgs-unstable.udiskie
    pkgs-unstable.ueberzug
    pkgs-unstable.unzip
    pkgs-unstable.unrar
    pkgs-unstable.viewnior
    pkgs-unstable.vifm
    pkgs-unstable.vivaldi
    pkgs-unstable.vivaldi-ffmpeg-codecs
    pkgs-unstable.vivaldi-widevine
    pkgs-unstable.vlc
    pkgs-unstable.vscodium
    pkgs-unstable.whatsapp-for-linux
    pkgs-unstable.whois
    pkgs-unstable.wireguard-tools
    pkgs-unstable.xarchiver
    pkgs-unstable.xmrig
    pkgs-unstable.xclip
    pkgs-unstable.xournalpp
    pkgs-unstable.yq
    pkgs-unstable.zathura
    pkgs-unstable.zoom-us
    pkgs.zsh
  ];

  # neovim
  programs.neovim = import ../../program/editor/neovim/default.nix;
  # programs.neovimj = import ../../program/editor/neovim/java.nix;

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
    };
  };

  # Git
  programs.git = {
    enable = true;
    userEmail = "chai@adabtive.nl";
    userName = "Chai Stofkoper";
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
    "~/.config/nvim/colors/SpaceMacs.vim".source = ./program/editor/neovim/configs/SpaceMacs.vim;
    "~/.config/nvim/coc-settings.json".source = ./program/editor/neovim/configs/coc-settings.json;
    "~/eslintrc.js".source = ./program/editor/neovim/configs/eslintrc.js;
    "~/.config/i3/config".source = ./program/window-manager/i3/config;
    "~/.config/i3/xrandr-2.sh".source = ./program/window-manager/i3/xrandr-2.sh;
    "~/.config/i3/xrandr-1.sh".source = ./program/window-manager/i3/xrandr-1.sh;
    "~/.config/i3/xrandr-1920.sh".source = ./program/window-manager/i3/xrandr-1920.sh;
    "~/.dmenurc".source = ../../program/window-manager/i3/.dmenurc;
  };
  xdg.configFile = {
    "dunst/dunstrc".source = ../../de/notifications/dunst/dunstrc;
  };
  services.lorri.enable = true;

}
