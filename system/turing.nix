{ config, pkgs, lib, ... }:

{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
  };

  networking = {
    hostName = "turing";
  };

  time.hardwareClockInLocalTime = true;
}
