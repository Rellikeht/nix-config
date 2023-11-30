# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, ... }:
let
pkgImport = import ./pkgs.nix;

in
with pkgImport;

{

  imports =
    [
      ./packages.nix
      ./programs.nix
      ./environment.nix
      ./gits.nix
      ./services.nix
      ./source.nix
      ./root.nix

      ./user-configuration.nix
      ./home-manager.nix
      ./other-local.nix

      ./hardware-configuration.nix
      ./devices.nix
      ./devices-local.nix
      ./commands.nix
    ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ ];

#     This is for having packages downloaded declaratively
    pkgs = import "${nixexprs}" {

#       Just in case
      inherit (config.nixpkgs) config
        overlays localSystem crossSystem;
    };

#	    This enables all collections through pkgs
    packageOverrides = rec {
      nixos = pkgImport.pkgs;
      unstable = pkgImport.unstable;
      home-manager = pkgImport.homeManagerPkgs;
    };

  };

#   This puts nixos pkgs in /etc
#   For nixPath purposes ?
  environment.etc = {
    "nixpkgs".source = "${nixexprs}";
    "unstable".source = "${unstableExprs}";
  };

  nix = {
    package = pkgs.nixFlakes;

#     This makes nixpkgs downloaded before available
#     for building system
    nixPath = [
      "nixpkgs=/etc/nixpkgs"
      "unstable=/etc/unstable"
      "nixos-config=/etc/nixos/configuration.nix"
    ];

    settings = {
      auto-optimise-store = true;
      allowed-users = [
        "@wheel"
      ];

      experimental-features = [
        "nix-command"
        "flakes" # one day...
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

    stateVersion = sysVer; # Did you read the comment?
  };

}

# TODO conditional imports
