# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  # config,
  ...
}:
with pkgs; let
  # myR = rWrapper.override {
  #   packages = with rPackages;
  #     [
  #       ggplot2
  #       units
  #       languageserver
  #       vioplot
  #     ]
  #     ++ (with pkgs; [udunits]);
  # };
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
    python =
      [
        pypy310
        myPython
        pylyzer
      ]
      ++ (with unstable; [
        ruff
      ]);

    jdks = [
      # jdk11
      jre8
      jdk17
    ];

    java = [
      java-language-server
    ];

    haskell = with unstable; ([
      ]
      ++ (with haskellPackages; [
        stack
        # cabal
        vector
        hashtables
        unordered-containers
      ]));

    others =
      [
        # good latex, but not needed now
        #    texlive.combined.scheme-full # ?
        #    texlab

        # pforth

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
        # myR
      ]
      ++ (with unstable; [
        tree-sitter
        julia-bin
      ])
      ++ (with lua54Packages; [
        lua
      ])
      ++ (with builds; [
        minizinc-ide-bin
      ]);

    langs =
      python
      ++ haskell
      ++ java
      ++ jdks
      ++ others;
  }
