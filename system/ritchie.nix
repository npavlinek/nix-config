{ config, pkgs, lib, ... }:

{
  boot.loader.systemd-boot.enable = true;

  networking = {
    hostName = "ritchie";
  };
}
