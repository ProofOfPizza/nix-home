{ config, pkgs, ... }:

{
  imports = [
    ../program/editor/neovim/default.nix
    ../program/file-manager/vifm/index.nix
    # Files to source for zsh config
    ../program/shell/zsh/sources.nix
  ];

  home.packages = with pkgs; [

    # Common CLI tools
    gnupg
    fzf
    ripgrep
    udiskie

    # Development
    neovim
    jq
    yq
    git-crypt
    dnsutils
    whois
    nodejs

    # Overview
    htop
    wtf
    neofetch
  ];

  # Git
  programs.git = {
    enable = true;
    userEmail = "laagislaag@gmail.com";
    userName = "ProoOfPizza";
#    signing.key = "BD939B63A45C6CAE";
#    signing.signByDefault = true;
  };

  # Environment
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  # Zsh Shell
  programs.zsh = import ../program/shell/zsh/default.nix;
}
