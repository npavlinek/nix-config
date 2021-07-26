{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      jetbrains-mono
      keepassxc
      ledger
      ncdu
      noto-fonts
      noto-fonts-extra
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
    fzf.enable = true;
    home-manager.enable = true;
    man.generateCaches = true;
    zathura.enable = true;
  };

  services = {
    pasystray.enable = true;
    syncthing.enable = true;
  };
}
