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
Available presets
```
        "general"
        "general_alt"
        "general_alt2"
        "general_alt3"
        "general_alt4"
        "general_alt5"
        "general_alt6"
        "general_mgts"
        "general_mgts2"

        "ultimatefix"
        "ultimatefix_alt"
        "ultimatefix_alt_extended"
        "ultimatefix_universal"
        "ultimatefix_universalv2"
        "ultimatefix_universalv3"
        "ultimatefix_mgts"

        "preset_russia"
        "russiafix"
        "renixos"
```
<hr/>
<div>

  <h3 align="center">Special Thanks: </h3>

  [Snowy-Fluffy](https://github.com/Snowy-Fluffy)

  [hand7s](https://github.com/s0me1newithhand7s)

  [aca](https://github.com/aca/)
  
</div>

<hr/>
