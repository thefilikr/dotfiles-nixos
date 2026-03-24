{
  description = "NixOS Niri desktop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { self, nixpkgs, niri, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/desktop/configuration.nix

        niri.nixosModules.niri
      ];

      specialArgs = { inherit inputs; };
    };
  };
}
