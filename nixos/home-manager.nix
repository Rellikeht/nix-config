# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

# pkgs, config, option, lib, stdenv, modulesPath
{ ... }:
let
pkgImport = import ./pkgs.nix;

in
with pkgImport;

{
# TODO
#  imports = [ home-manager.nixos ];

#  users.default = { ... }: {};

}

