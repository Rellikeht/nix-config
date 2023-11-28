# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

# TODO do that with flakes maybe
let
sysVer = "23.05";
getChan = addr: import (fetchTarball addr);
universalConf = {config = {allowUnfree = true;};};

stableLink = "https://nixos.org/channels/nixos-${sysVer}/nixexprs.tar.xz";
unstableLink = "https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz";
homeManagerLink = "https://github.com/nix-community/home-manager/archive/release-${sysVer}.tar.gz";

# Mismatch, probably needs whole system using unstable
#homeManagerLink = "https://github.com/nix-community/home-manager/archive/master.tar.gz";

pkgsTarball = fetchTarball stableLink;
pkgs = import pkgsTarball universalConf;

#pkgs = getChan stableLink universalConf;

unstable = getChan unstableLink universalConf;

home-manager = fetchTarball homeManagerLink;
homeManagerPkgs = (import home-manager) {};

in
{
  inherit sysVer getChan universalConf;
  inherit stableLink unstableLink homeManagerLink;
  inherit pkgs pkgsTarball;
  inherit unstable;
  inherit home-manager homeManagerPkgs;

}

# TODO make channels of that (may be undoable without flakes)?
