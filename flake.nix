{
  description = "nix-env-selector";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nix-npm-buildpackage.url = "github:serokell/nix-npm-buildpackage";

  outputs = { self, nixpkgs, flake-utils, nix-npm-buildpackage }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "nix-env-selector";
      systems = flake-utils.lib.defaultSystems;
      preOverlays = [ nix-npm-buildpackage.overlay ];
      overlay = (final: prev: {
        nix-env-selector = rec {
          nes = { isShell }: with final; with pkgs; buildYarnPackage {
            src = ./.;
            buildInputs = [ nodePackages.typescript ];
            yarnBuildMore = ''
              tsc -p ./
            '';
            installPrefix = "share/vscode/extensions/arterrian.nix-env-selector";
            postInstall = ''
              mkdir -p $out/out;
              cp ./out/extension.js $out/out;

              mkdir tmp;
              mv $out tmp;
              mkdir -p "$out/$installPrefix"
              find tmp -mindepth 2 -maxdepth 2 | xargs -d'\n' mv -t "$out/$installPrefix/"
            '';
          };
          defaultPackage = ves { isShell = false; };
          devShell = ves { isShell = true; };
        };
      });
    };
}
