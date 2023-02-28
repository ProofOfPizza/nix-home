{ pkgs ? import <pkgs-unstable> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    age
    awscli2
    sops
    terraform
    nodejs-18_x
  ];
}
