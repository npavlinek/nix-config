{ pkgs, ... }:

let
  vim-saturnite = pkgs.vimUtils.buildVimPlugin {
    name = "vim-saturnite";
    src = pkgs.fetchFromGitHub {
      owner = "habamax";
      repo = "vim-saturnite";
      rev = "d8676a1aabfe471c5341871b5afc788a2d9b8c3a";
      sha256 = "08gjkw5nkm2fsn31rzgl2q2r884y8mlh0w5ysp3wl0fsypw4vfqc";
    };
  };
  myPlugins = with pkgs.vimPlugins; [
    vim-ledger
    vim-nix
    vim-saturnite
  ];
  myConfig = builtins.readFile ./vimrc;
in {
  programs.vim = {
    enable = true;
    extraConfig = myConfig;
    plugins = myPlugins;
  };
}
