{ ... }:

{
  imports = [ 
    ./foundryvtt
    ./hardware-configuration.nix
    ../../../common/linux.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    copyKernels = true;
    fsIdentifier = "label";
    extraConfig = "serial; terminal_input serial; terminal_output serial";
  };

  boot.kernelParams = [ "console=ttyS0" ];

  networking.hostName = "web-host";

  nix.automaticUpgrades.enable = true;

  sops.defaultSopsFile = ./secrets.yaml;

  systemd.network.networks.external = {
    enable = true;
    matchConfig.Name = "enp*";
    networkConfig = {
      DHCP = "ipv4";
    };
  };

  time.timeZone = "America/New_York";

  system.stateVersion = "20.09";
}
