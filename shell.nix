{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "nix-config-dev";
  nativeBuildInputs = with pkgs; [ nixfmt ];
}

