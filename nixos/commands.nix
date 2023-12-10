# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  lib,
  stdenv,
  ...
}: let
in {
  system = {
    # TODO only during recompilation
    activationScripts = {
      #      updatedb =
      #        "
      #        echo Running updatedb
      #        ${config.services.locate.locate}/bin/updatedb
      #        ";
    };
  };

  environment = {
    extraInit = "";
    extraSetup = "";
  };
}
