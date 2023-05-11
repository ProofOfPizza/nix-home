{ stdenv, fetchFromGitHub, pkgs-unstable }:

stdenv.mkDerivation rec {
  pname = "coc-nvim";
  version = "latest";

  src = fetchFromGitHub {
    owner = "neoclide";
    repo = "coc.nvim";
    rev = "b28b8dc4278f0c68f14b74609d73169c88c97ec4";
    sha256 = "Btj7crJo0zk8/uF/RXtbGOiD3fQxzxKwmK+mMhf2s0I=";
    # rev = "v0.0.80";
    # sha256 = "1c2spdx4jvv7j52f37lxk64m3rx7003whjnra3y1c7m2d7ljs6rb";
  };
  buildInputs = [ pkgs-unstable.yarn ];
  dontBuild = true;
  installPhase = ''
    yarn install --frozen-lockfile
     mkdir -p $out
     cp -r ./ $out
  '';

    # echo "leukkkkk============= $out"
    # mkdir -p $out
    # cp -r ./ $out
}
