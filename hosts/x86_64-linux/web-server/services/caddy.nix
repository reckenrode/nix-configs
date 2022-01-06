{ config, ... }:

{
  networking.nftables.ruleset = ''
    table inet filter {
      chain input {
        tcp dport { http, https } accept
        udp dport { http, https } accept
      }
    }
  '';

  services.caddy = {
    enable = true;
    config = ''
      www.largeandhighquality.com {
        tls /var/lib/acme/largeandhighquality.com/fullchain.pem /var/lib/acme/largeandhighquality.com/key.pem

        root * /srv

        header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"

        encode zstd gzip

        file_server
      }
    '';
  };

  users.users.caddy.extraGroups = [ "acme-certs" ];
}
