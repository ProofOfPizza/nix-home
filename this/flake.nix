{
  description = "My NixOS Configuration with Vim etc and Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        my-nixos = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [

            ./configuration.nix ];
        };
      };

      packages.${system} = {
        vimConfig = import ./vim/default.nix;
      };
    };
}
