{ nixpkgs ? import <nixpkgs> {} }:
let
  inherit (nixpkgs) pkgs;

  purescriptPackages = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "aa94aeac3a6ad9b4dfa0e807ad1421097d74f663";
    sha256 = "1kfhi6rscgf165zg4f1s0fgppygisvc7dppxb93n02rypxfxjirm";
  }) {
    inherit pkgs;
  };

  nixPackages = [
    pkgs.nodejs-10_x
    pkgs.yarn
    purescriptPackages.purs-0_13_4
    purescriptPackages.spago
  ];
in
pkgs.mkShell {
  name = "vscode-env-selector";
  buildInputs = nixPackages;
}