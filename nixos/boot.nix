# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  # {{{
  pkgs,
  config,
  ...
  # }}}
}: let
in {
  boot = {
    loader = {
      # {{{
      timeout = 2;

      grub = {
        # {{{
        enable = true;
        # theme = pkgs.nixos-grub2-theme;
        useOSProber = true;
      }; # }}}
    }; # }}}

    tmp = {
      # {{{
      cleanOnBoot = true;
      useTmpfs = true;
      tmpfsSize = "100%";
    }; # }}}

    kernel = {
      # {{{
      sysctl = {
        "vm.swappiness" = 10;
      };
    }; # }}}

    # ?
    # kernelPackages = null;
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_zen;

    kernelModules = [
      # {{{
      "uinput"
      "ntfs3"
      "kvm"

      # ??
      # "acpi-cpufreq"

      "cpufreq_powersave"
      "cpufreq_conservative"
      "cpufreq_ondemand"
      "cpufreq_userspace"
    ]; # }}}

    kernelParams = [
      # {{{
      # this repairs governors
      "intel_pstate=passive"
    ]; # }}}

    extraModulePackages = with config.boot.kernelPackages; [
      # {{{
    ]; # }}}

    supportedFilesystems = [
      # {{{
      "ntfs"
      "exfat"
      "fat32"

      "zfs"
      "xfs"
      "btrfs"
      "f2fs"
    ]; # }}}

    initrd = {
      # {{{
      enable = true;

      kernelModules = [
        # {{{
        # "ntfs3"
        # "kvm"
        "i915"

        # # TODO ?
        # "acpi-cpufreq"
        # "cpufreq_powersave"
        # "cpufreq_conservative"
        # "cpufreq_ondemand"
        # "cpufreq_userspace"
      ]; # }}}
    }; # }}}

    binfmt = {
      registrations = {
        # {{{
        appimage = {
          # {{{
          wrapInterpreterInShell = false;
          interpreter = "${pkgs.appimage-run}/bin/appimage-run";
          recognitionType = "magic";
          offset = 0;
          mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
          magicOrExtension = ''\x7fELF....AI\x02'';
        }; # }}}
      }; # }}}
    };
  };
}
