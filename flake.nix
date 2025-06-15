{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    devenv.url = "github:cachix/devenv";
    flake-utils.url = "github:numtide/flake-utils";
    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    typst-packages = {
      url = "github:typst/packages";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      systems,
      nixpkgs,
      flake-parts,
      typix,
      ...
    }:
    flake-parts.lib.mkFlake
      {
        inherit inputs;
      }
      {
        imports = [
          inputs.treefmt-nix.flakeModule
          inputs.git-hooks-nix.flakeModule
          inputs.devenv.flakeModule
        ];
        systems = import inputs.systems;

        perSystem =
          {
            config,
            pkgs,
            system,
            typix,
            ...
          }:
          let
            stdenv = pkgs.stdenv;
            typix = inputs.typix;

            udevgothic_nf = pkgs.fetchzip {
              url = "https://github.com/yuru7/udev-gothic/releases/download/v2.1.0/UDEVGothic_NF_v2.1.0.zip";
              sha256 = "sha256-55SHOQD+6eJ2L3+95eofr18fp1nFeBKcZvZq8gfj7rA=";
              stripRoot = true;
            };

            noto-sans-jp = pkgs.fetchFromGitHub {
              owner = "google";
              repo = "fonts";
              rev = "main";
              hash = "sha256-Ap3fjh6yGkI0oP8BqG6wOB0aLFbAuHRNt/Z9fp2v3mw=";
            };

            typixLib = typix.lib.${system};
            src = typixLib.cleanTypstSource ./.;
            typstPackagesSrc = pkgs.symlinkJoin {
              name = "typst-packages-src";
              paths = [
                "${inputs.typst-packages}/packages"
              ];
            };

            typstPackagesCache = pkgs.stdenv.mkDerivation {
              name = "typst-packages-cache";
              src = typstPackagesSrc;
              dontBuild = true;
              installPhase = ''
                mkdir -p "$out"
                cp -LR --reflink=auto --no-preserve=mode -t "$out" "$src"/*
              '';
            };

            git-secrets' = pkgs.writeShellApplication {
              name = "git-secrets";
              runtimeInputs = [ pkgs.git-secrets ];
              text = ''
                git secrets --scan
              '';
            };
          in
          {
            treefmt = {
              projectRootFile = "flake.nix";
              programs = {
                nixfmt.enable = true;
              };

              settings.formatter = { };
            };

            pre-commit = {
              check.enable = true;
              settings = {
                hooks = {
                  treefmt.enable = true;
                  ripsecrets.enable = true;
                  git-secrets = {
                    enable = true;
                    name = "git-secrets";
                    entry = "${git-secrets'}/bin/git-secrets";
                    language = "system";
                    types = [ "text" ];
                  };
                };
              };
            };

            devShells.default = typix.lib.${system}.devShell {
              packages = with pkgs; [
                nil
                tinymist
              ];

              fontPaths = [
                "${udevgothic_nf}" 
                "${noto-sans-jp}/ofl/notosansjp"
                # "${pkgs.noto-fonts-cjk-sans}/share/fonts/opentype/noto-cjk"
                "${pkgs.raleway}share/fonts/truetype"
              ];

              enterShell = '''';
            };
          };
      };
}
