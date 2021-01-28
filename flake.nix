{
  description = "nix-env-selector";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nix-npm-buildpackage.url = "github:serokell/nix-npm-buildpackage";

  outputs = { self, nixpkgs, flake-utils, nix-npm-buildpackage }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "vscode-env-selector";
      systems = flake-utils.lib.defaultSystems;
      preOverlays = [ nix-npm-buildpackage.overlay ];
      overlay = (final: prev: {
        vscode-env-selector = rec {
          ves = { isShell }: with final; with pkgs; buildYarnPackage {
            src = ./.;
            buildInputs = [ nodePackages.typescript ];
            yarnBuildMore = ''
              tsc -p ./
            '';
            postInstall = ''
              mkdir -p $out/out;
              cp ./out/extension.js $out/out;
            '';
          };
          defaultPackage = ves { isShell = false; };
          devShell = ves { isShell = true; };
        };
      });
    };
}
