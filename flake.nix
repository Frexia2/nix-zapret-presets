{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    inputs:
    let
      forAllSystems =
        f:
        inputs.nixpkgs.lib.genAttrs
          [
            "x86_64-linux"
            "aarch64-linux"
            "aarch64-darwin"
          ]
          (
            system:
            f (
              import inputs.nixpkgs {
                inherit
                  system
                  ;
              }
            )
          );
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      packages = forAllSystems (pkgs: {
        hostlists = pkgs.callPackage ./packages/hostlists.nix { };
        secrets = pkgs.callPackage ./packages/secrets.nix { };
      });

      nixosModules.presets =
        {
          self,
          pkgs,
          lib,
          config,
          ...
        }:
        import ./modules/nixos.nix {
          inherit
            self
            pkgs
            lib
            config
            ;
        };
    };
}
