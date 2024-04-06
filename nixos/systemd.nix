# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
# pkgs, config, option, lib, stdenv, modulesPath
{pkgs, ...}: let
  b = builtins;
in {
  systemd = {
    ctrlAltDelUnit = "";

    sleep.extraConfig = ''
      # ????

      AllowSyspend=yes
      # AllowHibernate=yes
      # AllowHybridSleep=yes

      SuspendState=mem
      # HibernateDelaySec=
    '';

    extraConfig = ''
      DefaultTimeoutStopSec=15s
    '';
  };
}
