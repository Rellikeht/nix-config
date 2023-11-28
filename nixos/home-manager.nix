# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

# config, option, lib, stdenv, modulesPath
{ ... }:
let
pkgImport = import ./pkgs.nix;

in
with pkgImport;

{
  imports = [ (import "${home-manager}/nixos") ];
  home-manager.users.default = { ... }: {
    home.stateVersion = sysVer;
  };
}

