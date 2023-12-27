# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  # homeManagerExprs,
  # home-manager,
  ...
}: let
  # pkgImport = import ./pkgs.nix;
in {
  # No idea what happens here
  # No idea how to incorporate shit into config
  # Modularity is very hard

  # Infinite recursion loves me so much
  # imports = [(import "${homeManagerExprs}/nixos")];
  # imports = [home-manager];

  # This should be done after changing config
  # to flake :(
  # home-manager.users.default = {...}: {
  #   home.stateVersion = pkgImport.sysVer;
  # };
}
