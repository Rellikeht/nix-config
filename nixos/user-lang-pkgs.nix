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
      jdk11
      jdk17
    ];

    java = [
      java-language-server
      # jdt-language-server
    ];

    haskell = with unstable; ([
        stack
      ]
      ++ (with haskellPackages; [
        vector
        hashtables
        unordered-containers
      ]));

    others = [
      # good latex, but not needed now
      #    texlive.combined.scheme-full # ?
      #    texlab

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

      # myR
      builds.minizinc-ide-bin
      # minizinc
    ];

    langs = python ++ haskell ++ java ++ jdks ++ others;
  }
