{ ... }:

{
  roles.dhcpV6Client = {
    enable = true;
    interfaces = [ "eth0" ];
  };

  services.resolved.dnssec = "false";

  systemd.network.networks.lan = {
    enable = true;
    matchConfig.Name = "eth0";
    networkConfig = {
      DHCP = "yes";
      IPv6PrivacyExtensions = true;
      IPv6AcceptRA = true;
    };
  };
}
