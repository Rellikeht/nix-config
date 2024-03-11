# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{pkgs, ...}:
with pkgs; let
  myR = pkgs.rWrapper.override {
    packages = with rPackages;
      [
        ggplot2
        units
        languageserver
        vioplot
      ]
      ++ (with pkgs; [udunits]);
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
      flake8
      autopep8

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
      # pypy3
      pypy310
      myPython
      ruff
    ];

    jdks = [
      jdk11
      jdk17
    ];

    java = [
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
      pforth
      unstable.tree-sitter
      # unstable.julia

      # No idea how well works caching of that :(
      (unstable.julia.withPackages [
        "LanguageServer"
        "OhMyREPL"
        "Revise"
        "BenchmarkTools"

        "Plots"
        "Unitful"

        "JSON3"
        "CSV"
      ])

      builds.minizinc-ide-bin
      # minizinc
    ];

    langs = python ++ haskell ++ java ++ jdks ++ others;
  }
