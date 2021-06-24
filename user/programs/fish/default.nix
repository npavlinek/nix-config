{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    promptInit = ''
      any-nix-shell fish --info-right | source
    '';
    shellAliases = {
      ll = "ls -lh";
      ls = "ls --color -F";
    };
    shellInit = ''
      set -g fish_greeting
    '';
  };
}
