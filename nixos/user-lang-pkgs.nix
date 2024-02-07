# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{pkgs, ...}:
with pkgs; let
  myR = pkgs.rWrapper.override {
    packages = with rPackages; [
      ggplot2
      units
      languageserver
      vioplot
    ];
  };

  pythonProv = python311;
  pythonPackages = ps:
    with ps; [
      bpython
      pip
      python-lsp-server

      pynvim
      yt-dlp
      mypy

      matplotlib
      pandas
      numpy
      sympy
    ];
  myPython = pythonProv.withPackages pythonPackages;
in
  with pkgs; rec {
    # Because of versions
    python = [
      pypy3
      #pypy310
      myPython
    ];

    java = [
      jdk11
      jdk17

      java-language-server
      jdt-language-server
    ];

    haskell = with unstable; [
      haskellPackages.vector
      haskellPackages.hashtables
      haskellPackages.unordered-containers
      stack
    ];

    others = [
      # good latex, but not needed now
      #    texlive.combined.scheme-full # ?
      #    texlab

      myR
      julia
      pforth
      unstable.tree-sitter

      # TODO build shit from source
      # and add solvers
      minizinc
    ];

    langs = python ++ haskell ++ java ++ others;
  }
