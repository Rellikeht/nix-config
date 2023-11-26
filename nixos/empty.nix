# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

{ config, option, lib, ... }:
let
pkgImport = import ./pkgs.nix;

in
{
  inherit pkgs unstable oldRel;
}

