{ inputs, ... }:
{
  imports = [
    ./hyprland.nix
    # ./hyprpaper.nix
    # ./config.nix
    # ./hyprlock.nix
    # ./variables.nix
    inputs.hyprland.homeManagerModules.default
  ];
}
