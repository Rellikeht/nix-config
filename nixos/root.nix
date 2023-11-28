# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

{ pkgs, config, option, ... }:
let

in
{
  users.users.root = {
    shell = pkgs.zsh;
  };
}

