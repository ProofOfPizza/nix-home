{ config, lib, pkgs, ... }:
let
  cfg = config.elemental.home.program.editor.neovim;
  coc = import ./coc.nix;
in
{
  options.elemental.home.program.editor.neovim = {
    enable = lib.mkEnableOption "Enable the neovim editor";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.neovim ];

    xdg.configFile."nvim/coc-settings.json".source =
      builtins.toFile "coc-settings.json" (builtins.toJSON (coc { config = config; }));
    xdg.configFile."nvim/general.vimrc".source = ./general.vimrc;
  };
}
