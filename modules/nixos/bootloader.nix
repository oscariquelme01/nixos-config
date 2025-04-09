{
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "auto";
    memtest86.enable = true;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
}
