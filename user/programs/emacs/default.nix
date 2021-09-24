{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
  };

  home.file."emacs-config" = {
    source = ./.emacs.d;
    target = ".emacs.d";
    recursive = true;
  };
}
