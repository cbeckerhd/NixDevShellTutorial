{
  description = "DevShell using compiled C program";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;

    swap = pkgs.stdenv.mkDerivation {
      name = "swap";
      version = "0.0.1";

      src = fetchGit {
        url = "https://github.com/cbeckerhd/NixDevShellTutorial_CProjectWithDependencies.git";
        rev = "184cf34773c12301ceba2cec4967768191d9c981";
      };

      buildInputs = [ pkgs.blas ];

      buildPhase = "gcc -o swap swap.c -lblas";

      installPhase = ''
        mkdir -p $out/bin
        mv swap $out/bin
      '';
    };
  in
  {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [
        swap
      ];
    };
  };
}
