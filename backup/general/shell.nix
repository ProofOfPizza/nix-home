{ pkgs ? import <nixpkgs> { } }:
let unstable = import <nixos-unstable> { overlays = [ (import ./cypress-overlay.nix) ]; };
#    cypress = unstable.callPackage ./cypress.nix {};
in
pkgs.mkShell {
  buildInputs = [
    unstable.dotnet-sdk_3
    unstable.nodejs-15_x
    pkgs.yarn
    unstable.selenium-server-standalone
    pkgs.geckodriver
    pkgs.openjdk11
    unstable.cypress
      (with unstable.dotnetCorePackages; combinePackages [ sdk_3_0 net_5_0 ])
  ];
  shellHook = ''
    export CYPRESS_INSTALL_BINARY=0
    export CYPRESS_RUN_BINARY=$(which Cypress)
  '';
}
