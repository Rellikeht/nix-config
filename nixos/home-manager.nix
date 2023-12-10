# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{...}: let
  pkgImport = import ./pkgs.nix;
in {
  # currently cant replace that with attributes from
  # main file :(
  imports = [(import "${pkgImport.homeManager}/nixos")];

  home-manager.users.default = {...}: {
    home.stateVersion = pkgImport.sysVer;
  };
}
