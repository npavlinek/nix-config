{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      cloc
      dunst
      hack-font
      keepassxc
      ncdu
      speedcrunch
      tree
      unzip
      xclip
      xmonad-log
    ] ++ map (pkg: callPackage pkg { }) (import ./scripts);

  imports = (import ./programs) ++ (import ./services);

  news.display = "silent";

  programs = {
    chromium.enable = true;
    feh.enable = true;
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
