final: prev: {
  exodus = prev.exodus.overrideAttrs (old: rec {
    version = "22.12.5";

    src = final.fetchurl {
      url = "https://downloads.exodus.com/releases/${old.pname}-linux-x64-${version}.zip";
      # sha256 = "sha256-6+FrMUi35yn5JrnHCvcdqegsEO8nm5yl6mxJxIScTZU=";
      sha256 = "1grsq0scl928ry9qbk370jsix8745n6rgwdy3cf6kddc3m97p1gy";
    };

    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ final.makeWrapper ];

    postFixup = ''
      wrapProgram $out/Exodus --prefix LD_LIBRARY_PATH : ${final.xorg.libxshmfence}/lib
    '';
  });
}
