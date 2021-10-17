final: prev: {
  exodus = prev.exodus.overrideAttrs (old: rec {
    version = "21.9.10";

    src = final.fetchurl {
      url = "https://downloads.exodus.io/releases/${old.pname}-linux-x64-${version}.zip";
      sha256 = "sha256-6+FrMUi35yn5JrnHCvcdqegsEO8nm5yl6mxJxIScTZU=";
    };

    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ final.makeWrapper ];

    postFixup = ''
      wrapProgram $out/Exodus --prefix LD_LIBRARY_PATH : ${final.xorg.libxshmfence}/lib
    '';
  });
}
