# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
# pkgs, config, option, lib, stdenv, modulesPath
{
  #  {{{
  pkgs,
  lib,
  ...
  #  }}}
}: let
  #  {{{
  b = builtins;
  unstable = pkgs.unstable;
  #  }}}

  rofi = final: prev: {
    rofi = prev.rofi.override {
      #  {{{
      plugins = with prev; [
        #  {{{
        rofi-calc
        rofi-emoji
        #rofi-file-browser
      ]; #  }}}
    }; #  }}}
  };

  epsonscan2 = final: prev: {
    #  {{{
    epsonscan2 = prev.epsonscan2.override {
      withNonFreePlugins = true;
    };
  }; #  }}}

  mpv-unwrapped = final: prev: {
    #  {{{
    mpv-unwrapped = prev.mpv-unwrapped.override {
      # ffmpeg = pkgs.ffmpeg_5-full;
      ffmpeg = pkgs.ffmpeg-full;
    };
  }; #  }}}

  pass = final: prev: {
    #  {{{
    pass = prev.pass.override {
      dmenu = pkgs.builds.dmenu;
    };
  }; #  }}}

  # This does almost nothing :(
  zsh = final: prev: {
    #  {{{

    # https://discourse.nixos.org/t/how-to-recompile-a-package-with-flags/3603
    # https://stackoverflow.com/questions/42136197/how-to-override-compile-flags-for-a-single-package-in-nixos
    zsh = prev.zsh.overrideAttrs (
      old: {
        NIX_CFLAGS_COMPILE = ["-O2" "-march=native" "-mtune=native"];
        NIX_ENFORCE_NO_NATIVE = false;
      }
    );

    # Could this shit even work for this scenario?
    # https://nixos.wiki/wiki/Build_flags
    # zsh = prev.zsh.override {
    #   # nixpkgs.localSystem = {
    #   #   gcc.arch = "native";
    #   #   gcc.tune = "native";
    #   # };

    #   # stdenv = prev.impureUseNativeOptimizations prev.stdenv;
    #   # nixpkgs = prev.nixpkgs prev.stdenv;
    #   # NIX_CFLAGS_COMPILE = ["-O2" "-march=native" "-mtune=native"];
    #   NIX_ENFORCE_NO_NATIVE = false;
    # };
  }; #  }}}

  mpv = final: prev: {
    #  {{{
    mpv = prev.mpv.override {
      scripts = with final.mpvScripts; [
        #  {{{
        mpris
        # gets fucked on some videos
        # thumbnail
        # needs additional work
        # thumbfast
        quality-menu
        sponsorblock
      ]; #  }}}
    };
  }; #  }}}

  vis = final: prev: {
    #  {{{
    vis = prev.vis.override (prevArgs: {
      lua = let
        luaEnv =
          prevArgs.lua.withPackages
          (ps: with ps; [lpeg luafilesystem]);
      in {
        withPackages = f: luaEnv;
        luaversion =
          luaEnv.luaversion;
      };
    });
  }; #  }}}
in {
  nixpkgs.overlays = [
    #  {{{
    rofi
    epsonscan2
    mpv
    mpv-unwrapped
    vis
    zsh
    pass
  ]; #  }}}
}
