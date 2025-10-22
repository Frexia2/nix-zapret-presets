{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hostlists = {
      url = "github:Snowy-Fluffy/zapret.cfgs";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, hostlists, home-manager, nur, ... } @ inputs:
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
		overlays = [ nur.overlays.default ];
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
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.frexia = {
	    imports =[  ./home-manager/services.nix
			./home-manager/theming.nix
			./home-manager/preferences.nix
			./home-manager/sway.nix
			./home-manager/mako.nix
			./home-manager/foot.nix
			./home-manager/firefox.nix
			./home-manager/apps.nix
		];
	    };
            home-manager.extraSpecialArgs = { inherit self inputs; };
          }

	  {
		 nixpkgs.overlays = [ nur.overlays.default ];
	  }
        ];
      };
    };
}
