{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hostlists = {
      url = "github:Snowy-Fluffy/zapret.cfgs";
      flake = false;
    };
  };

  outputs =
    { self, nixpkgs, hostlists, ... } @ inputs:
    let
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs
          [
            "x86_64-linux"
            "aarch64-linux"
            "aarch64-darwin"
          ]
          (
            system:
            f (
              import nixpkgs {
                inherit system;
              }
            )
          );
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      packages = forAllSystems (pkgs: {
        hostlists = pkgs.callPackage ./packages/hostlists.nix {
          inherit inputs;
        };
        secrets = pkgs.callPackage ./packages/secrets.nix { };
      });

      nixosModules.presets =
        { self, pkgs, lib, config, ... }:
        import ./modules/nixos.nix {
          inherit self pkgs lib config;
        };

      # FIXED: Properly pass self and inputs to the NixOS configuration
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # Pass special arguments that modules might need
        specialArgs = { inherit self inputs; };
        modules = [
          ./configuration.nix
          self.nixosModules.presets
        ];
      };
    };
}
