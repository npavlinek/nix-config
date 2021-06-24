{ pkgs, ... }:

let
  myPlugins = with pkgs.vimPlugins; [
    fzf-vim
    gruvbox-community
    nord-vim
    vim-glsl
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
