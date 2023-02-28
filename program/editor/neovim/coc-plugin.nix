{ pkgs, fetchFromGitHub }:

pkgs.vimUtils.buildVimPlugin {
  pname = "coc-nvim";
  version = "v0.82";

  src = fetchFromGitHub {
    owner = "neoclide";
    repo = "coc.nvim";
    rev = "v0.0.82";
    sha256 = "TIkx/Sp9jnRd+3jokab91S5Mb3JV8yyz3wy7+UAd0A0=";
  };
}
