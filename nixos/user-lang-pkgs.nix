# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{pkgs, ...}:
with pkgs; let
  myR = rWrapper.override {
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
      pylsp-mypy
      mypy

      pynvim
      yt-dlp
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
    python =
      [
        # pypy3
        pypy310
        myPython
        pylyzer
      ]
      ++ (with unstable; [
        ruff
      ]);

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
      unstable.julia

      # Not cached enough :(
      # And read only file system
      # This may be job for home manager activation
      # (unstable.julia.withPackages [
      #   "LanguageServer"
      #   "OhMyREPL"
      #   "Revise"

      #   #   "BenchmarkTools"
      #   #   "Plots"
      #   #   "Unitful"
      #   #   "JSON3"
      #   #   "CSV"
      # ])

      builds.minizinc-ide-bin
      # minizinc
    ];

    langs = python ++ haskell ++ java ++ jdks ++ others;
  }
