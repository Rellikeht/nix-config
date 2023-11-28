# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

# TODO do that with flakes maybe
let

# Version of whole system
sysVer = "23.05";

getChan = addr: import (fetchTarball addr);
universalConf = {
  config = {
    allowUnfree = true;
  };
};

# Links to pkgs repos
stableLink = "https://nixos.org/channels/nixos-${sysVer}/nixexprs.tar.xz";
unstableLink = "https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz";
homeManagerLink = "https://github.com/nix-community/home-manager/archive/release-${sysVer}.tar.gz";
# TODO NUR at some day

# downloaded nixpkgs for usage as pkgs in system
nixexprs = fetchTarball stableLink;

# for installing packages ?
pkgs = import nixexprs universalConf;

# And the same things here
unstable = getChan unstableLink universalConf;
home-manager = fetchTarball homeManagerLink;
homeManagerPkgs = (import home-manager) {};

in
{
#   And some simple exporting
  inherit sysVer getChan universalConf;
  inherit stableLink unstableLink homeManagerLink;
  inherit pkgs nixexprs;
  inherit unstable;
  inherit home-manager homeManagerPkgs;

}

# TODO make channels of that (may be undoable without flakes)?
