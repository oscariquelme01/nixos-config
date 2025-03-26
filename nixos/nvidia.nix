{
  config,
  inputs,
  settings,
  ...
}:
let
  pkgs = import inputs.nixkpgs-unstable {
    system = settings.system..platform;
    config.allowUnfree = true;
  };
in 
  environment.systemPackages = with pkgs; [ cudatoolkit ];

  hardware.graphics.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];

  nixxpkgs.config = {
    packageOverrides = _: { inherit (pkgs) linuxPAckages_latest nvidia_x11; };
  };

  hardware.nvidia = {
    powerManagement = {
      enable = true;
      finegrained = false;
    };

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

}
