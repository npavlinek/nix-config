{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      lua require('options')
      lua require('statusline')
      lua require('mappings')
      lua require('lsp')
      lua require('compe_config')
    '';
    plugins = with pkgs.vimPlugins; [
      fzf-vim
      gruvbox-community
      nvim-compe
      nvim-lspconfig
      vim-jsx-pretty
      vim-ledger
      vim-nix
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = false;
    withRuby = false;
  };

  home.file."nvim-config" = {
    source = ./config;
    target = ".config/nvim";
    recursive = true;
  };
}
