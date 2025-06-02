This flake brings some of [Snowy-Fluffy's zapret configurations](https://github.com/Snowy-Fluffy/zapret.cfgs) to NixOS \
Example configuration:
```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zapret-presets.url = "github:kotudemo/zapret-presets";

  };

  outputs = {
    self,
    nixpkgs,
    zapret-presets,
    ...
  } @ inputs:
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem rec {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          inputs.zapret-presets.nixosModules.presets
        ];
      };
    };
  };
}
```
```nix
# configuration.nix
{
services = {
    zapret = {
      enable = true;
      sf_presets = {
        enable = true;
        preset = "renixos";
      };
    };
  };
}
```
