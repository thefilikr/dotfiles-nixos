{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "desktop";

  users.users.user = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
    ];
  };

  security.sudo.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}
