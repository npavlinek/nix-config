{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
      pull = {
        rebase = "true";
      };
      rebase = {
        autosquash = "true";
      };
    };
    userEmail = "niko.pavlinek@gmail.com";
    userName = "Niko Pavlinek";
  };
}
