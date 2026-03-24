{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
  };

  home.packages = with pkgs; [
    git
    curl
    wget
  ];
}
