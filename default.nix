{ nixpkgs ? import <nixpkgs> {} }:
let
  inherit (nixpkgs) pkgs;

  nixPackages = [
    pkgs.nodejs-10_x
    pkgs.yarn
    pkgs.nodePackages.bower
    pkgs.nodePackages.pulp
  ];
in
pkgs.stdenv.mkDerivation {
  name = "vscode-env-selector";
  buildInputs = nixPackages;
  postInstall =
    ''
      yarn install
      bower install
    '';
}