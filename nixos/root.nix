# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  config,
  ...
}: let
in {
  users.users.root = {
    # shell = pkgs.zsh;
    shell = pkgs.bashInteractive;
    # shell = config.users.defaultUserShell;
  };
}
