# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  userHome,
  homeMode,
  ...
}: let
  downloads = builtins.mkDerivation {
    # TODO downloads copying
  };
in {
  # TODO move without infinite recursion
  # maybe simple let
  fileSystems = {
    "${userHome}/Downloads" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "size=8G"
        "mode=${homeMode}"
      ];
    };
  };
}
# TODO home manager ??
# TODO directories
# TODO symlinks

