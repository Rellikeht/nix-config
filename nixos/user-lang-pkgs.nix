# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

{ ... }:
let
pkgImport = import ./pkgs.nix;

in
with pkgImport;
with pkgs;

rec {

  # Because of versions
  python = [
    pypy3
#    unstable.pypy310

    python311Packages.mypy
    python311Packages.matplotlib
    python311Packages.pandas
    python311Packages.numpy
    python311Packages.sympy

    python311Packages.yt-dlp

  ];

  others = [

    jdk11
    jdk17
    jetbrains.idea-community
    gradle
    java-language-server
    jdt-language-server

    julia
    haskell-language-server
    pforth

    rPackages.vioplot
    rPackages.units
    rPackages.ggplot2

    # additional solvers
    unstable.minizinc

  ];

  langs = others ++ python;
}
