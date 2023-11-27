# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs, config, ... }:
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
      ./other-local.nix

      ./hardware-configuration.nix
      ./devices.nix
      ./devices-local.nix
      ./commands.nix
    ];

  nix = {
    package = pkgs.nixFlakes;

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
# Copy the NixOS configuration file and
# link it from the resulting system
# (/run/current-system/configuration.nix).
# This is useful in case you
# accidentally delete configuration.nix.
    copySystemConfiguration = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It's perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

    stateVersion = "23.11"; # Did you read the comment?
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ ];

#    packageOverrides = pkgs: rec {
    packageOverrides = rec {
      nixos = getChan
        "https://nixos.org/channels/nixos-${config.system.stateVersion}/nixexprs.tar.xz"
        {config = config.nixpkgs.config;};

      nixos-unstable = getChan
        "https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz"
        {config = config.nixpkgs.config;};

      home-manager = getChan
        "https://github.com/nix-community/home-manager/archive/master.tar.xz"
        {};

    };

  };

}

# TODO conditional imports
