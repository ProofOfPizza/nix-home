final: prev: {
  cypress = prev.cypress.overrideAttrs (oldAttrs: {
    version = "6.4.0";
    src = prev.fetchzip {
      url = "https://cdn.cypress.io/desktop/6.4.0/linux-x64/cypress.zip";
      sha256 = "1i29ycsjfmpnkj3hm8w45vsbd0ippqzdsah6mk04rwfcrw6y7pyy";
    };
    installPhase = let
      old = "copyExtension(pathToExtension, extensionDest)";
      # This has only been tested against Cypress 6.0.0!
      new =
        "copyExtension(pathToExtension, extensionDest).then(() => fs_1.default.chmodAsync(extensionBg, 0o0644))";
    in ''
      sed -i 's/${old}/${new}/' \
          ./resources/app/packages/server/lib/browsers/chrome.js
    '' + oldAttrs.installPhase;
  });
}
