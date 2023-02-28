{ pkgs ? import <nixpkgs> { } }:
let unstable = import <nixos-unstable> { overlays = [ (import ./dotnet-sdk_3-overlay.nix) ]; };
#    cypress = unstable.callPackage ./cypress.nix {};
in
pkgs.mkShell {
  buildInputs = [
    unstable.dotnet-sdk_3
    unstable.dotnetPackages.Nuget
    unstable.nodejs-14_x
    unstable.jdk11
    unstable.maven
    unstable.awscli2
    unstable.mysql80
    unstable.python27
    unstable.yarn
    unstable.sass
  ];
  shellHook = ''
    export CYPRESS_INSTALL_BINARY=0
    export CYPRESS_RUN_BINARY=${unstable.cypress}/bin/Cypress
  '';
}

