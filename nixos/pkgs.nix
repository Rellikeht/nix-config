# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

# TODO do that with flakes maybe
let
sysVer = "23.05";
getChan = addr: import (fetchTarball addr);
universalConf = {config = {allowUnfree = true;};};
#unstable = import <nixos-unstable> universalConf;

in
{
  inherit sysVer;

# TODO do this well
#  pkgs = getChan
#    "https://nixos.org/channels/nixos-${sysVer}/nixexprs.tar.xz"
#    universalConf;

#  oldRel = getChan
#    "https://nixos.org/channels/nixos-23.05/nixexprs.tar.xz"
#    universalConf;

  unstable = getChan
    "https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz"
    universalConf;

#  home-manager = getChan
#    "https://github.com/nix-community/home-manager/archive/master.tar.xz"
#    {};

}

