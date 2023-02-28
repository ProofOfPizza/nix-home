{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "coc-nvim";
  version = "v0.80";

  src = fetchFromGitHub {
    owner = "neoclide";
    repo = "coc.nvim";
    rev = "v0.0.80";
    sha256 = "1c2spdx4jvv7j52f37lxk64m3rx7003whjnra3y1c7m2d7ljs6rb";
  };
  dontBuild = true;
  installPhase = ''
    echo "leukkkkk============= $out"
    mkdir -p $out
    cp -r ./ $out
  '';

}
