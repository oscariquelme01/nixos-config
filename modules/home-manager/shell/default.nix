{ config, lib, pkgs, ...}:

{
  imports = [
    ./starship.nix
    ./zsh.nix
  ];
}
