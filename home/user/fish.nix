{ ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#desktop";
      update = "nix flake update ~/nixos-config";
    };
  };
}
