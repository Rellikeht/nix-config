# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

# TODO do that with flakes maybe
let
sysVer = "23.05";
getChan = addr: import (fetchTarball addr);
universalConf = {config = {allowUnfree = true;};};

stableLink = "https://nixos.org/channels/nixos-${sysVer}/nixexprs.tar.xz";
unstableLink = "https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz";
homeManagerLink = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
#homeManagerLink = "https://github.com/nix-community/home-manager/archive/release-${sysVer}.tar.gz";

#pkgs = getChan stableLink universalConf;
unstable = getChan unstableLink universalConf;
home-manager = getChan homeManagerLink {};

#unstable = import <nixos-unstable> universalConf;

in
{
  inherit sysVer getChan universalConf;
  inherit stableLink unstableLink homeManagerLink;
  inherit unstable home-manager;

}

# TODO make channels of that
