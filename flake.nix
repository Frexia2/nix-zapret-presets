{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    secret_files.url = "github:kotudemo/secret_files";
    zapret-hostlists.url = "github:kotudemo/zapret-hostlists";
  };

  outputs = {
    self,
    nixpkgs,
    secret_files,
    zapret-hostlists,
    ...
  } @ inputs: let
    forAllSystems = f:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ] (system: f (import nixpkgs {inherit system;}));
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);
    nixosModules.presets = {
      self,
      config,
      pkgs,
      lib,
      ...
    }:
      import ./module.nix {
        inherit self config pkgs lib;
        inputs = inputs; # вот здесь передаём весь inputs
      };
  };
}
