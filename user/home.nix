{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      dejavu_fonts
      iosevka
      jetbrains-mono
      keepassxc
      ledger
      liberation_ttf
      ncdu
      speedcrunch
      stCustom
      tree
      unzip
      xclip
    ] ++ map (pkg: callPackage pkg { }) (import ./scripts);

  imports = (import ./programs) ++ (import ./services);

  news.display = "silent";

  programs = {
    chromium.enable = true;
    feh.enable = true;
    firefox.enable = true;
    home-manager.enable = true;
    man.generateCaches = true;
    zathura.enable = true;
  };

  services = {
    pasystray.enable = true;
    syncthing.enable = true;
  };
}
