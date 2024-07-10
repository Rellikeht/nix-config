# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  # {{{
  pkgs,
  config,
  ...
  # }}}
}: let
in {
  fileSystems = {
    "/" = {
      # {{{
      options = [
        # {{{
        "nodiratime"
        "noatime"
      ]; # }}}
    }; # }}}
  };

  zramSwap = {
    # {{{
    enable = true;
    algorithm = "zstd";
    memoryPercent = 90;
    priority = 256;
  }; # }}}
}
