{
  description = "Ultralightweight JSON parser in ANSI C (BitRipple fork)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem flake-utils.lib.allSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      packages = {
        default = pkgs.stdenv.mkDerivation {
          name = "cjson";
          src = ./.;

          nativeBuildInputs = with pkgs; [
            cmake
          ];

          # Install the static library as well as the shared one, so
          # consumers can link either.
          cmakeFlags = [
            "-DBUILD_SHARED_AND_STATIC_LIBS=ON"
          ];

          # Run cJSON's own test suite as part of the build.
          doCheck = true;
        };
      };
    });
}

# vim:sw=2:sts=2:et
