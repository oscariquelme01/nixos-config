{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Third party firefox-addons, packaged with nix
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nightly versions cause we are that hardcore
    # hyprland.url = "github:hyprwm/Hyprland"; # doesn't follow nixpkgs becasue 'libgbm' is missing (?) might try later on in the future
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay" ;

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    username = "topi";
  in {
    # Include overlays in the outputs
    overlays = import ./overlays {inherit inputs;};

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      topi = nixpkgs.lib.nixosSystem {
        specialArgs = {
            host = "desktop";
            inherit inputs outputs username;
        };
        # > Our main nixos configuration file <
        modules = [./modules/nixos/configuration.nix];
      };
    };
  };
}
