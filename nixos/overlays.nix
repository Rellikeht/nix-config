# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
# pkgs, config, option, lib, stdenv, modulesPath
{pkgs, ...}: let
  b = builtins;

  # OMG THIS WORKS
  myRofi = final: prev: {
    rofi = prev.rofi.override {
      plugins = with prev; [
        rofi-calc
        rofi-emoji
        #rofi-file-browser
      ];
    };
  };

  epsonscan2 = final: prev: {
    epsonscan2 = prev.epsonscan2.override {
      withNonFreePlugins = true;
    };
  };
in {
  nixpkgs.overlays = [
    myRofi
    epsonscan2
  ];
}
