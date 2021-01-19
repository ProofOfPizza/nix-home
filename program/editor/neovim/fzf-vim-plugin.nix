{ pkgs, fetchFromGitHub }:

pkgs.vimUtils.buildVimPluginFrom2Nix {
  pname = "fzf";
  version = "0.25.0";

  src = fetchFromGitHub {
    owner = "junegunn";
    repo = "fzf";
    rev = "0.25.0";
    sha256 = "1j5bfxl4w8w3n89p051y8dhxg0py9l98v7r2gkr63bg4lj32faz8";
  };
}
