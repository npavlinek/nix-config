{ pkgs, ... }:

{
  programs.taskwarrior = {
    enable = true;
    colorTheme = "solarized-dark-256";
    dataLocation = "${builtins.getEnv "HOME"}/shared/main/task";
  };
}
