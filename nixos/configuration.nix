# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{config, ...}: let
  pkgImport = import ./pkgs.nix;
  locals = import /etc/nixos-local/default.nix;
  vars = import /etc/nixos-local/local-vars.nix;
in
  with pkgImport; {
    imports = with pkgImport;
      [
        ./packages.nix
        ./overlays.nix
        ./programs.nix

        ./environment.nix
        ./security.nix
        ./services.nix
        ./commands.nix

        ./user-configuration.nix
        ./root.nix
        ./gits.nix

        ./hardware.nix
        ./devices.nix
      ]
      ++ locals.modules;

    nixpkgs = {
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [];

        #     This is for having packages downloaded declaratively
        pkgs = import "${nixexprs}" {
          #       Just in case
          inherit
            (config.nixpkgs)
            config
            # overlays
            
            localSystem
            crossSystem
            ;
        };

        # This enables all collections through pkgs
        packageOverrides = with pkgImport; rec {
          nixos = pkgs;
          unstable = pkgs-unstable;
          home-manager = homeManager;
          builds = pkgImport.myBuilds.packages."x86_64-linux";
          inherit nur;
        };
      };

      # inherit overlays;
    };

    #   This puts nixos pkgs in /etc
    #   For nixPath purposes ?
    environment.etc = {
      "nixpkgs".source = "${nixexprs}";
      "unstable".source = "${unstableExprs}";
      # Dirty workaround
      "rofi/themes".source = "${pkgs.rofi}/share/rofi/themes";
    };

    nix = {
      # channel.enable = false;
      package = pkgs.nixFlakes;

      # This makes nixpkgs downloaded before available
      # for building system
      nixPath = [
        "nixpkgs=/etc/nixpkgs"
        "unstable=/etc/unstable"
        "nixos-config=/etc/nixos/configuration.nix"
      ];

      # daemonCPUSchedPolicy = "idle";

      settings = {
        auto-optimise-store = true;
        access-tokens = "github.com=${vars.githubToken}";
        allowed-users = [
          "@users"
        ];

        experimental-features = [
          "nix-command"
          "flakes" # one day...
        ];

        substituters = [
          "https://nix-community.cachix.org"
          "https://cache.nixos.org/"
        ];

        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
        ];

        trusted-substituters = [
        ];
      };
    };

    system = {
      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It's perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

      inherit stateVersion; # Did you read the comment?
      name = sysName;
    };
  }
# TODO conditional imports

