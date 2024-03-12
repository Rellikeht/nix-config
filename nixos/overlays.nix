# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
# pkgs, config, option, lib, stdenv, modulesPath
{pkgs, ...}: let
  # b = builtins;
  # OMG THIS WORKS
  unstable = pkgs.unstable;

  rofi = final: prev: {
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

  mpv-unwrapped = final: prev: {
    mpv-unwrapped = prev.mpv-unwrapped.override {
      # ffmpeg = pkgs.ffmpeg_5-full;
      ffmpeg = pkgs.ffmpeg-full;
    };
  };

  mpv = final: prev: {
    mpv = prev.mpv.override {
      scripts = with final.mpvScripts; [
        mpris
        # quality-menu
      ];
    };
  };
in {
  nixpkgs.overlays = [
    rofi
    epsonscan2
    mpv
    mpv-unwrapped
  ];
}
