# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./shell
    ./browser
    ./git.nix
    ./neovim.nix
  ];

  # nixpkgs = {
  #   # You can add overlays here
  #   overlays = [
  #     (final: _: {
  #       # this allows you to access `pkgs.unstable` anywhere in your config
  #       unstable = import inputs.nixpkgs-unstable {
  #         inherit (final.stdenv.hostPlatform) system;
  #         inherit (final) config;
  #       };
  #     })
  #   ];
  #   # Configure your nixpkgs instance
  #   config = {
  #     # Disable if you don't want unfree packages
  #     allowUnfree = true;
  #     # Workaround for https://github.com/nix-community/home-manager/issues/2942
  #     allowUnfreePredicate = _: true;
  #   };
  # };
  #
  home = {
    username = "topi";
    homeDirectory = "/home/topi";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    # unstable.neovim # Temporary fix, grab nvim from unstable to get the 0.11 release
    ripgrep
    alacritty
    rofi-wayland
    nerdfonts
    tmux
    pavucontrol
    todoist-electron
    wl-clipboard
    discord
    gcc
    nix
    redis
    bun
    obsidian
    waybar
    jetbrains.idea-community
    teams-for-linux
    nodejs_23
    openfortivpn
    zathura
    texliveFull
    cargo
    unzip
    (flameshot.override { enableWlrSupport = true; })
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
