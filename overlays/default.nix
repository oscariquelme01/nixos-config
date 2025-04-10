# https://nixos.wiki/wiki/Overlays
# See examples here:
# https://github.com/Misterio77/nix-config/blob/d39c4bfa163ab6ecccf2affded0a3e5ad4b8cc7b/overlays/default.nix
{inputs, ...}: {
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
