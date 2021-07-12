#!/usr/bin/env sh

set -e

nix_config_root="$HOME/src/nix-config"
nix_config_dest="$HOME/.config/nixpkgs"

copy_user_config() {
  printf 'copying user config...\n'
  [ -d $nix_config_dest ] && rm -rf $nix_config_dest
  mkdir -p $nix_config_dest
  cp -r $nix_config_root/user/* $nix_config_dest/
}

copy_system_config() {
  printf 'copying system config...\n'
  doas cp $nix_config_root/system/configuration.nix /etc/nixos/
}

set_up_home_manager() {
  copy_user_config
  printf 'setting up home manager...\n'
  nix-channel --add \
    https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
  nix-shell '<home-manager>' -A install
}

install_user() {
  copy_user_config
  printf 'installing user config...\n'
  home-manager switch
}

install_system() {
  copy_system_config
  printf 'installing system config...\n'
  doas nixos-rebuild switch --upgrade
}

case $1 in
  setup)
    set_up_home_manager
    ;;
  user)
    install_user
    ;;
  system)
    install_system
    ;;
  all)
    install_system
    install_user
    ;;
esac
