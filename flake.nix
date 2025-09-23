{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    secret_files.url = "github:kotudemo/secret_files";
    zapret-hostlists.url = "github:kotudemo/zapret-hostlists";
  };

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

      nixosModules.presets =
        {
          self,
          pkgs,
          lib,
          config,
          ...
        }:
        import ./module.nix {
          inherit
            self
            inputs
            pkgs
            lib
            config
            ;
        };
    };
}
