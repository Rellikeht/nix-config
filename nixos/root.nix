# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

{ pkgs, config, option, ... }:
let
pkgImport = import ./pkgs.nix;

in
with pkgImport;
{
  users.users.root = {
    shell = pkgs.zsh;
  };
}

