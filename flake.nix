{
  description = "Sample Nix ts-node build";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, flake-utils, gitignore, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
      in
      with pkgs; {
        devShell = mkShell {
          buildInputs = [ ];
          shellHook = ''
            eval "$(micromamba shell hook posix)"
            export LD_LIBRARY_PATH=$(nix eval --raw nixpkgs#addOpenGLRunpath.driverLink)/lib
            micromamba activate sovits5
          '';
        };
      });
}
