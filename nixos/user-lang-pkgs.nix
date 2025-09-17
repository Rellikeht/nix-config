# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{pkgs, ...}: let
  pythonProv = pkgs.python313;

  pythonPackages = ps:
    with ps; [
      #  {{{
      bpython
      pip
      uv
      pynvim
      yt-dlp
      matplotlib
    ]; #  }}}
  myPython = pythonProv.withPackages pythonPackages;
in
  with pkgs; rec {
    python =
      [
        #  {{{
        # pypy310
        myPython
      ] #  }}}
      ++ (with unstable; [
        #  {{{
      ]); #  }}}

    jdks = [
      #  {{{
      jdk
    ]; #  }}}

    java = [
      #  {{{
      # java-language-server
      jdt-language-server
    ]; #  }}}

    haskell = with unstable; ([
        #  {{{
        # cabal
        cabal-install
        stack
      ] #  }}}
      ++ (with haskellPackages; [
        #  {{{
        haskell-language-server
        floskell
        # vector
        # hashtables
        # unordered-containers
      ])); #  }}}

    others =
      [
        #  {{{
        # pforth
        # myR
      ] #  }}}
      ++ (with unstable; [
        #  {{{
        # texlive.combined.scheme-medium
        # texlab

        # julia-bin
        gotools
      ]) #  }}}
      ++ (with lua54Packages; [
        #  {{{
        # lua
      ]) #  }}}
      ++ (with nodePackages; [
        #  {{{
        prettier
      ]) #  }}}
      ++ (with builds; [
        #  {{{
        # minizinc-ide-bin
      ]); #  }}}

    langs =
      #  {{{
      python
      ++ haskell
      ++ java
      ++ jdks
      ++ others; #  }}}
  }
