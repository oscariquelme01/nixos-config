{
  sound.enable = true;

  hardware.pulseaudio.enable = true;
  # automatically load modules
  hardware.pulseaudio.extraConfig = "load-module module-combine-sink";

  nixpkgs.config.pulseaudio = true;
}
