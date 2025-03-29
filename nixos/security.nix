# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
# pkgs, config, option, lib, stdenv, modulesPath
{...}: let
  b = builtins;
  noPassCmd = name: {
    # {{{
    groups = ["wheel"];
    noPass = true;
    keepEnv = true; # ??
    cmd = name;
  }; # }}}
in {
  security = {
    # {{{
    lockKernelModules = false;
    rtkit.enable = true;
    # }}}

    doas = {
      # {{{
      enable = true;
      extraRules =
        [
          # {{{
          {
            # {{{
            groups = ["wheel"];
            keepEnv = true;
            persist = true;
          } # }}}
        ] # }}}
        ++ map noPassCmd [
          # {{{
          "brightnessctl"
          "mount"
          "umount"
          "tlp-stat"
        ]; # }}}
    }; # }}}

    sudo = {
      # {{{
      enable = true;
      extraRules = [
        # {{{
        {
          # {{{
          groups = ["wheel"];
          commands = ["ALL"];
        } # }}}
      ]; # }}}
    }; # }}}

    polkit = {
      enable = true;
    };
  };
}
