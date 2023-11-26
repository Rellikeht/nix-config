# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

{ config, option, ... }:
let
  vars = import ./local-vars.nix;

  downloads = builtins.mkDerivation {
# TODO downloads copying
  };

in
{

# TODO move without infinite recursion
# maybe simple let
  fileSystems = {
    "${vars.home}/Downloads" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "size=6G"
        "mode=777"
      ];
    };
  };

}

# TODO home manager ??
# TODO directories
# TODO symlinks
