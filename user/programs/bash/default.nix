{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" ];
    historySize = 10000;
    initExtra = builtins.readFile ./config.bash;
    shellAliases = {
      ll = "ls -lh";
      ls = "ls --color -F";
    };
    shellOptions = [ "histappend" ];
  };
}
