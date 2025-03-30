# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  userName,
  userHome,
  homeMode,
  userGroup,
  # userUid,
  # userGid,
  ...
}: let
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
