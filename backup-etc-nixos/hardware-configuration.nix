# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/78177ede-71a9-4b1d-96c6-c1d0363d1bd4";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/651cea7f-5d8c-48fe-9c3f-7f23189aa501";
      fsType = "ext2";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/9f1be1bd-e17d-4057-b780-50c0c5db78a2"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
