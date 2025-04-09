# Didn't know how to name this file but it contains per program configurations that need to be set at root level, for example zsh as a default level need to be set as root. Some excepctions like hyprland will be configured in the wayland.nix as it made more sense
{ pkgs, ... }:
{
  programs.zsh.enable = true;

  # dynamic libs linking
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libz # required to compile intellij projects
  ];
}
