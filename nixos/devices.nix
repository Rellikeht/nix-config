# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

{ pkgs, config, option, lib, ... }:
let
pkgImport = import ./pkgs.nix;

in
with pkgImport;
{

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

    kernelModules = [];
    kernelParams = [];
    extraModulePackages = with config.boot.kernelPackages; [
      perf
    ];

    supportedFilesystems = [
      "ntfs"
      "exfat"
      "fat32"
    ];

  };

# TODO zram
}
