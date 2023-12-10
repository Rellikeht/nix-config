# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
# TODO do that with flakes maybe
let
  # Version of whole system
  sysVer = "23.11";

  getChan = addr: import (fetchTarball addr);
  universalConf = {config = {allowUnfree = true;};};

  # Links to pkgs repos
  stableLink = "https://nixos.org/channels/nixos-${sysVer}/nixexprs.tar.xz";
  unstableLink = "https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz";
  homeManagerLink = "https://github.com/nix-community/home-manager/archive/release-${sysVer}.tar.gz";
  # TODO NUR at some day

  #oldVer = "23.05";
  #oldLink = "https://nixos.org/channels/nixos-${oldVer}/nixexprs.tar.xz";
  #oldPkgs = getChan oldLink universalConf;

  # downloaded nixpkgs for usage as pkgs in system
  nixexprs = fetchTarball stableLink;
  # for installing packages ?
  pkgs = import nixexprs universalConf;

  # And the same things here
  unstableExprs = fetchTarball unstableLink;
  unstable = import unstableExprs universalConf;

  homeManager = fetchTarball homeManagerLink;
  homeManagerPkgs = (import homeManager) {};
in {
  #   And some simple exporting
  inherit sysVer getChan universalConf;
  inherit stableLink unstableLink homeManagerLink;
  inherit nixexprs pkgs;
  inherit unstable unstableExprs;
  inherit homeManager homeManagerPkgs;

  #  inherit oldPkgs;
}
# TODO make channels of that (may be undoable without flakes)?

