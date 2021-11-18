# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      (modulesPath + "/profiles/all-hardware.nix")
    ];

  boot.initrd.availableKernelModules = [
    "reset_raspberrypi"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/06d45151-9770-4c2c-b061-b118a3710e3c";
      fsType = "xfs";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/ACDA-EE06";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/8575b966-d556-4bcf-bff9-72964cb23414"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
