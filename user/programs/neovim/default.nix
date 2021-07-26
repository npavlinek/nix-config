{ pkgs, ... }:

let
  vim-warlock = pkgs.vimUtils.buildVimPlugin {
    name = "vim-warlock";
    src = pkgs.fetchFromGitHub {
      owner = "hardselius";
      repo = "warlock";
      rev = "12c7772d35fd6956940d716bb71c9f3855a45a12";
      sha256 = "0vii8fd098mbxd2b29cgm3kj9a0lln9jf2mg5hlxkf3zsp752lcf";
    };
  };
in {
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
      nvim-compe
      nvim-lspconfig
      vim-jsx-pretty
      vim-ledger
      vim-nix
      vim-warlock
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
