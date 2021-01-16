{ config, pkgs, lib, ... }:

{
  imports = [
    ../program/editor/neovim/default.nix
  ];

  elemental.home.program.editor.neovim.enable = true;

  home.packages = with pkgs; [
    # Utils
    nmap
    
    # Common CLI tools
    fzf
    ripgrep
    gnupg

    # Development
    ctags
    dnsutils
#    git-crypt
#    gitAndTools.gitFull
    jq
    nixpkgs-fmt
    nodejs
    yarn
    yq

    ## Python Dev


    # Files and networking
    whois

    # Media
    youtube-dl

    # Overview
    htop
    wtf
    neofetch

  ];


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
    # Aliases
  };

  # Environment
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };
}
