{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "24.05";

  networking.hostName = "niri-desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # пользователь
  users.users.user = {
    isNormalUser = true;
    description = "User";
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.fish;
  };

  # fish
  programs.fish.enable = true;

  # niri
  programs.niri.enable = true;

  # display manager (tuigreet)
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd niri-session";
        user = "greeter";
      };
    };
  };

  # графика
  hardware.opengl.enable = true;

  # звук
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # основные пакеты
  environment.systemPackages = with pkgs; [
    alacritty
    fish
    git
    wget
    curl

    waybar
    fuzzel
    wl-clipboard
    grim
    slurp
  ];

  # шрифты
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  # nix flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # sudo
  security.sudo.enable = true;
}
