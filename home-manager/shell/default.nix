{ config, lib, pkgs, ...}:

{
  imports = [
    ./starship.nix
    ./zsh.ni
  ];
}
