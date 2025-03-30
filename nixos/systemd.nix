# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
# pkgs, config, option, lib, stdenv, modulesPath
{
  pkgs,
  config,
  ...
}: let
  b = builtins;
in {
  systemd = {
    ctrlAltDelUnit = "";

    sleep.extraConfig =
      #  {{{
      ''
        # ????

        AllowSyspend=yes
        # AllowHibernate=yes
        # AllowHybridSleep=yes

        SuspendState=mem
        # HibernateDelaySec=
      ''; #  }}}

    extraConfig = ''
      DefaultTimeoutStopSec=15s
    '';

    # mounts = [
    #   {
    #     # /tmp {{{
    #     type = "tmpfs";
    #     where = "/tmp";
    #     what = "tmpfs";
    #     options = b.concatStringsSep "," [
    #       "1777"
    #       "strictatime"
    #       "rw"
    #       "nosuid"
    #       "nodev"
    #       "size=100%"
    #       # "size=${config.boot.tmp.tmpfsSize}"
    #     ];
    #   } #  }}}
    # ];

    user = {
      services = {
        #
      };

      #
    };
  };
}
