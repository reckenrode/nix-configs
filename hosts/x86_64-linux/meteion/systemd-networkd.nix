{ ... }:

{
  services.dhcpV6Client = {
    openFirewall = true;
    interfaces = [ "enp3s0" ];
  };

  services.resolved.dnssec = "true";

  systemd.network.networks.lan = {
    enable = true;
    matchConfig.Name = "enp3s0";
    networkConfig = {
      DHCP = "ipv4";
      IPv6PrivacyExtensions = true;
      IPv6AcceptRA = true;
    };
  };

  systemd.network.networks.wlan = {
    enable = true;
    matchConfig.Name = "wlan0";
    networkConfig = {
      DHCP = "ipv4";
      IPv6PrivacyExtensions = true;
      IPv6AcceptRA = true;
    };
  };
}
