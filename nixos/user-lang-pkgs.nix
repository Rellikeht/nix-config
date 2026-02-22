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
      ++ jdks
      ++ others; #  }}}
  }
