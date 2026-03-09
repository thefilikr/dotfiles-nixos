{
  config,
  lib,
  pkgs,
  modules,
  inputs,
  globals,
  ...
}: {

  imports = [ 
    ./hardware-configuration.nix 
    inputs.dms.nixosModules.greeter
];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; 

  programs.niri.enable = true;
  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "niri";
  };

  
  security.polkit.enable = true;
  programs.dconf.enable = true;
  services.xserver.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Minsk";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.filikr = {
    isNormalUser = true;
    description = "filikr";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    alacritty
    git
    curl
  ];

  system.stateVersion = "25.11";

}
