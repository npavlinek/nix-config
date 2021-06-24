{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    cleanTmpDir = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  environment.systemPackages = with pkgs; [ file killall ];

  hardware.pulseaudio.enable = true;

  nix = {
    autoOptimiseStore = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  networking = {
    hostName = "ritchie";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Ljubljana";

  i18n.defaultLocale = "en_US.UTF-8";

  programs = {
    fish.enable = true;
    ssh.startAgent = true;
    vim.defaultEditor = true;
  };

  security = {
    doas = {
      enable = true;
      extraRules = [{
        groups = [ "wheel" ];
        keepEnv = true;
      }];
    };
    sudo.enable = false;
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";

      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };

      displayManager = {
        defaultSession = "none+xmonad";
        lightdm.enable = true;
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      # TODO: Set up screen locker
      # xautolock = {
      #   enable = false;

      #   locker = "${pkgs.physlock}/bin/physlock";
      #   time = 1;
      #   killer = "/run/current-system/systemd/bin/systemctl suspend";
      #   killtime = 30;

      #   enableNotifier = true;
      #   notifier = ''${pkgs.dunst}/bin/dunstify "Locking in 10 seconds"'';
      # };
    };
  };

  users.users.nkpvk = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  system.stateVersion = "21.05";
}
