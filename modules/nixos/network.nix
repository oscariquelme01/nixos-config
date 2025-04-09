{
  networking.hostName = "topi";
  networking.hosts = {
    "0.0.0.0" = [ "www.instagram.com" ];
  };
  networking.nameservers = [ "8.8.8.8" ];
}
