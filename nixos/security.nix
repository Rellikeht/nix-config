# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
# pkgs, config, option, lib, stdenv, modulesPath
{...}: let
  b = builtins;
in {
  security = {
    # {{{
    lockKernelModules = false;
    rtkit.enable = true;
    # }}}

    doas = {
      # {{{
      enable = true;
      extraRules = [
        # {{{
        {
          # {{{
          groups = ["wheel"];
          keepEnv = true;
          noPass = true;
        } # }}}
      ]; # }}}
    }; # }}}

    sudo = {
      # {{{
      enable = true;
      wheelNeedsPassword = false;
    }; # }}}

    polkit = {
      enable = true;
    };
  };
}
