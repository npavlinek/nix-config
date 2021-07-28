{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    font = "JetBrains Mono 10";
    theme = "gruvbox-dark";
  };
}
