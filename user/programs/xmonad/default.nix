{ pkgs, ... }:

{
  xsession = {
    enable = true;

    initExtra = ''
      # Increase key repeat rate
      xset r rate 300 50

      ${pkgs.gnome3.networkmanagerapplet}/bin/nm-applet &
    '';

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./config.hs;
      extraPackages = hp: [ hp.dbus ];
    };
  };
}
