{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "24.11";

  # Включаем Dank Material Shell
  programs.dank-material-shell = {
    enable = true;
  };

}
