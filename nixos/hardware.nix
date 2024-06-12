# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
# pkgs, config, option, lib, stdenv, modulesPath
{
  pkgs,
  # config,
  ...
}: let
  b = builtins;
  pkgImport = import ./pkgs.nix;
  sysName = pkgImport.sysName;
in {
  networking = {
    hostName = sysName;
    networkmanager.enable = true;

    firewall = {
      # TODO
      # enable = false;
      allowPing = true;

      # Open ports in the firewall.
      #      allowedTCPPorts = [ ... ];
      #      allowedUDPPorts = [ ... ];
    };

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
        Policy = {
          AutoEnable = false;
        };
      };
    };

    sane = {
      enable = true;
      extraBackends = with pkgs; [
        epsonscan2
        epkowa
        utsushi

        sane-airscan
        hplipWithPlugin
      ];
    };

    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        mesa.drivers
      ];
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
    powertop.enable = true;
  };
}
