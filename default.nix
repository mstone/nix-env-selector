{ nixpkgs ? import <nixpkgs> {} }:
let
  inherit (nixpkgs) pkgs;

  purescriptPackages = import (pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "a5fd0328827ac46954db08f624c09eba981f1ab2";
      sha256 = "1g3bk2y8hz0y998yixz3jmvh553kjpj2k7j0xrp4al1jrbdcmgjq";
    }) {
    inherit pkgs;
  };

  nixPackages = [
    pkgs.nodejs-10_x
    pkgs.yarn
    purescriptPackages.purs-0_13_8
    purescriptPackages.spago
  ];
in
pkgs.mkShell {
  name = "vscode-env-selector";
  buildInputs = nixPackages;
}