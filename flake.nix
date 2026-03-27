{
  description = "Production NixOS config";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, niri, ... }:

  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

  in {

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {

      inherit system;

      modules = [

        ./hosts/desktop

        home-manager.nixosModules.home-manager
        niri.nixosModules.niri

        ./modules/system/boot.nix
        ./modules/system/networking.nix
        ./modules/system/locale.nix
        ./modules/system/sound.nix

        ./modules/desktop/niri.nix
        ./modules/desktop/fonts.nix

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.user =
            import ./home/user;
        }

      ];

    };

  };

}
