# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
# pkgs, config, option, lib, stdenv, modulesPath
{
  pkgs,
  config,
  ...
}: let
  b = builtins;
in {
  networking = {
    # hostName = "nixos";
    hostName = config.system.name;
    networkmanager.enable = true;

    firewall = {
      #      enable = false;
      allowPing = false;

      # TODO
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
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;

      extraConfig = "
        load-module module-switch-on-connect
      ";

      extraModules = with pkgs; [
        #pulseaudio-modules-bt
      ];
    };

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
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
}
