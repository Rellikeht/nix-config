# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{pkgs, ...}: let
in
  with pkgs; rec {
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

    r = [
      rPackages.vioplot
      rPackages.units
      rPackages.ggplot2
    ];

    java = [
      jdk11
      jdk17
      java-language-server
      jdt-language-server
    ];

    haskell = [
      haskellPackages.vector
      haskellPackages.hashtables
      haskellPackages.unordered-containers
      #    haskellPackages.unordered-intmap
    ];

    others = [
      # good latex, but not needed now
      #    texlive.combined.scheme-full # ?
      #    texlab

      julia
      pforth
      unstable.tree-sitter

      # TODO build shit from source
      # and add solvers
      minizinc
    ];

    langs = python ++ r ++ haskell ++ java ++ others;
  }
