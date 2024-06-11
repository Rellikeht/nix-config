# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  config,
  ...
}: let
in {
  fileSystems."/" = {
    options = [
      "nodiratime"
      "noatime"
    ];
  };

  boot = {
    loader = {
      timeout = 2;

      grub = {
        enable = true;
        # theme = pkgs.nixos-grub2-theme;
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

    # ?
    # kernelPackages = null;
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_zen;

    kernelModules = [
      "ntfs3"

      # TODO ?
      # "acpi-cpufreq"
      "cpufreq_powersave"
      "cpufreq_conservative"
      "cpufreq_ondemand"
      "cpufreq_userspace"
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

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 90;
    priority = 256;
  };
}
