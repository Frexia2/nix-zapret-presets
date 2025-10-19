{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hostlists = {
      url = "github:Snowy-Fluffy/zapret.cfgs";
      flake = false;
    };

    # Add Home Manager input
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";  # Use same nixpkgs as system
    };
  };

  outputs =
    { self, nixpkgs, hostlists, home-manager, ... } @ inputs:  # Add home-manager to inputs
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

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self inputs; };
        modules = [
          ./configuration.nix
          self.nixosModules.presets
          # Add Home Manager module
          home-manager.nixosModules.home-manager
          {
            # Home Manager configuration
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.frexia = import ./home.nix;
            
            # Optional: You can also add extra specialArgs for home-manager if needed
            home-manager.extraSpecialArgs = { inherit self inputs; };
          }
        ];
      };
    };
}
