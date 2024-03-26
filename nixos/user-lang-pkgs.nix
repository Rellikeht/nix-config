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
    ];
  myPython = pythonProv.withPackages pythonPackages;
in
  with pkgs; rec {
    python =
      [
        pypy310
        myPython
      ]
      ++ (with unstable; [
        ruff
        # :( )
        # pylyzer
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
        haskell-language-server
        floskell
        stack
        # cabal
        vector
        hashtables
        unordered-containers
        cabal-install
        stack
      ]));

    others =
      [
        # pforth
        # myR
      ]
      ++ (with unstable; [
        texlive.combined.scheme-medium
        texlab

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
