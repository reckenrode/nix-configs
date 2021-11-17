# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/445e403b-123e-4921-88e8-43a2e1ec77da";
      fsType = "xfs";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/201D-463F";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/8e1a2a31-8bb2-438a-862a-826e0498dda0"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
