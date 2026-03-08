{
  description = "NixOS config with Niri and DMS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Рекомендуется unstable

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Dank Material Shell
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable"; # Ветка stable
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, dms, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.filikr = {
            imports = [
              ./home.nix
              dms.homeModules.dank-material-shell # Модуль DMS для пользователя
            ];
          };
        }
      ];
    };
  };
}
