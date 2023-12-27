# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{...}: let
  pkgImport = import ./pkgs.nix;
in {
  # No idea what happens here
  # No idea how to incorporate shit into config
  # Modularity is very hard
  imports = [(import "${pkgImport.homeManagerExprs}/nixos")];

  home-manager.users.default = {...}: {
    home.stateVersion = pkgImport.sysVer;
  };
}
