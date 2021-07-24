{ pkgs, ... }:

{
  xsession = {
    enable = true;

    initExtra = ''
      # Increase key repeat rate
      xset r rate 300 50

      ${pkgs.gnome3.networkmanagerapplet}/bin/nm-applet &
    '';

    windowManager.awesome = {
      enable = true;
    };
  };

  home.file."awesome-config" = {
    source = ./config;
    target = ".config/awesome";
    recursive = true;
  };
}
