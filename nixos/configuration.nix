# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{config, ...}: let
  pkgImport = import ./pkgs.nix;
  locals = import /etc/nixos-local/default.nix;
  vars = import /etc/nixos-local/local-vars.nix;
in
  with pkgImport; {
    imports =
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

        ./hardware.nix
        ./devices.nix
      ]
      ++ locals.modules;

    nixpkgs = {
      config = {
        allowUnfree = true;

        permittedInsecurePackages = [
          # this doesn't help :(
          # "nix-2.16.2"
          # "nix"
        ];

        # pkgs downloaded in pkgs.nixexprs
        # no idea why or if this does anything
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
        packageOverrides = let
          system = config.nixpkgs.hostPlatform.system;
        in
          with pkgImport; {
            nixos = pkgs;
            unstable = pkgs-unstable;
            home-manager = homeManager;
            builds = pkgImport.myBuilds.packages.${system};
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
      "dhall/Prelude".source = "${dhallPrelude}";
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

