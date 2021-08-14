{ pkgs, ... }:

let
  myPlugins = with pkgs.vimPlugins; [
    vim-ledger
    vim-nix
  ];
  myConfig = builtins.readFile ./vimrc;
in {
  programs.vim = {
    enable = true;
    extraConfig = myConfig;
    plugins = myPlugins;
  };
}
