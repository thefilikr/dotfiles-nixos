{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "24.11";

  # Включаем Dank Material Shell
  programs.dank-material-shell = {
    enable = true;

    # ВАЖНО: Опции интеграции с niri
    niri = {
      enableKeybinds = true;  # Прописать стандартные шорткаты DMS (launcher, control center...)
      enableSpawn = true;      # Автозапуск DMS вместе с niri
    };

    # ВАЖНО: Отключаем systemd сервис, т.к. запуск через niri
    systemd.enable = false;    # Иначе DMS запустится дважды

    # Включаем нужные фичи
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableClipboardPaste = true; # Для вставки из истории буфера обмена
  };

  # Переменные окружения (те же, что и в прошлый раз)
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri";
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
  };

  # Полезные пакеты (DMS заменит многие из них, но базовые оставить можно)
  home.packages = with pkgs; [
    # Явно не ставим waybar, mako, fuzzel — их заменяет DMS
    alacritty      # Терминал
    brightnessctl  # Управление яркостью
    playerctl      # Управление медиа
    libnotify      # Для уведомлений (если нужно)
    swaybg         # Если захочешь отдельные обои (но DMS умеет сам)
  ];
}
