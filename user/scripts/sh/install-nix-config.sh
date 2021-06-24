#!/usr/bin/env sh

set -e

nix_config_root="$HOME/src/nix-config"

copy_user_config() {
  printf 'copying user config...\n'
  mkdir -p $HOME/.config/nixpkgs/
  cp -r $nix_config_root/user/* $HOME/.config/nixpkgs/
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
