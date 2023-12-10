# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{config, ...}: let
in {
  boot = {
    loader = {
      grub = {
        enable = true;
        #        theme = pkgs.nixos-grub2-theme;
        theme = null;
        useOSProber = true;
      };
    };

    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
    };

    kernel = {
      sysctl = {
        "vm.swappiness" = 10;
      };
    };

    # this sets kernel
    #    kernelPackages = null;

    kernelModules = [
      "ntfs3"
    ];

    kernelParams = [];
    extraModulePackages = with config.boot.kernelPackages; [];

    supportedFilesystems = [
      "ntfs"
      "exfat"
      "fat32"

      "zfs"
      "xfs"
      "btrfs"
      "f2fs"
    ];
  };

  # TODO zram
}
