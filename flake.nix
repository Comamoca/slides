{
  description = "My slides.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-marp.url = "github:tweag/nix-marp";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs =
    {
      self,
      nixpkgs,
      nix-marp,
      flake-utils,
      treefmt-nix,
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      stdenv = pkgs.stdenv;
      code = _: s: s;
    in
    {
      treefmt = treefmtEval.config.build.wrapper;
      formatter.x86_64-linux = self.treefmt;

      checks.x86_64-linux = {
        format = self.treefmt;
      };

      # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
      # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

      marp-cli = pkgs.writeShellApplication {
        name = "marp";
        text = code "bash" ''
          ${nix-marp.packages.x86_64-linux.marp-cli}/bin/marp "$@"
          export CHROME_PATH=${pkgs.google-chrome}/bin/google-chrome-stable 
        '';
      };

      marp-build = stdenv.mkDerivation {
        name = "marp-build";
        buildInputs = [
          self.marp-cli
          pkgs.google-chrome
          pkgs.jekyll
        ];
        nativeBuildInputs = [
          pkgs.noto-fonts-cjk-sans
        ];
        src = ./.;
        buildPhase = ''
          export HOME="$(mktemp -d)" 
          export CHROME_PATH=${pkgs.google-chrome}/bin/google-chrome-stable 

          for dir in */; do
            dir=''${dir%/}

            if [ -f "$dir/$dir.md" ]; then
              echo "$dir/$dir.md"
              marp --allow-local-files "$dir/$dir.md" -o "./site/slides/$dir.pdf"
              marp --allow-local-files "$dir/$dir.md" -o "./site/slides/$dir.html"
            fi
          done

          jekyll build
        '';
        installPhase = ''
          mkdir -p $out
          cp -r ./_site $out/
        '';
      };

      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          marp-cli
          google-chrome
          jekyll
          nil
        ];
      };

      # packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.hello;
      packages.x86_64-linux.default = self.marp-build;
    };
}
