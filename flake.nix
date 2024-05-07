{
  description = "Pandare";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    panda.url = "github:panda-re/panda/v1.8.24";
  };

  outputs = {
    self,
    nixpkgs,
    panda,
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

    pythonBundle =
      pkgs.python3.withPackages
      (ps: [
        ps.wheel
        ps.cffi
        ps.colorama
        (
          ps.callPackage
          ./pandare-pkg.nix
          {}
        )
      ]);
  in {
    devShells.${system}.default = pkgs.mkShell rec {
      name = "my-panda-project";

      nativeBuildInputs = [
        pythonBundle
      ];

      buildInputs = [
        panda.packages.${system}.default
      ];

      shellHook = ''
        echo ${pythonBundle}
        echo "Start developping now!"
      '';
    };
  };
}
