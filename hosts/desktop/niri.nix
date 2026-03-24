{ pkgs, ... }:

{
  programs.niri.enable = true;

  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd niri-session";
        user = "greeter";
      };
    };
  };

  environment.systemPackages = with pkgs; [

    alacritty
    waybar
    fuzzel

    wl-clipboard
    grim
    slurp

  ];

}