{ lib, buildVimPluginFrom2Nix, buildNeovimPluginFrom2Nix, fetchFromGitHub, fetchgit }:

final: prev:
{

nerdtree = buildVimPluginFrom2Nix {
    pname = "nerdtree";
    version = "2022-06-13";
    src = fetchFromGitHub {
      owner = "preservim";
      repo = "nerdtree";
      rev = "fc85a6f07c2cd694be93496ffad75be126240068";
      sha256 = "02z32hrh4ykv4waq22y9ng8hwxxm8s5f2kxqm57pkixyy6b8zvzi";
    };
    meta.homepage = "https://github.com/preservim/nerdtree/";
  };
}


