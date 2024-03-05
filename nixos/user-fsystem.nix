# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  userName,
  userHome,
  homeMode,
  userGroup,
  userUid,
  userGid,
  ...
}: let
  downloads = builtins.mkDerivation {
    # TODO downloads copying
  };
in {
  fileSystems = {
    "${userHome}/Downloads" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "size=8G"
        "mode=${homeMode}"
        "uid=${userName}"
        "gid=${userGroup}"
      ];
    };
  };
}
# TODO home manager ??
# TODO directories
# TODO symlinks

