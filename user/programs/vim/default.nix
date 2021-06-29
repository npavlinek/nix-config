{ pkgs, ... }:

let
  myPlugins = with pkgs.vimPlugins; [
    fzf-vim
    nord-vim
    vim-glsl
    vim-lsc
  ];

  myConfig = builtins.readFile ./config.vim;
  myPluginConfig = builtins.readFile ./plugins.vim;
in {
  programs.vim = {
    enable = true;
    extraConfig = myConfig + myPluginConfig;
    plugins = myPlugins;
  };
}
