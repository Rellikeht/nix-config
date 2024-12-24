# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  # {{{
  pkgs,
  config,
  ...
  # }}}
}: let
  path = [
    # {{{
    "/usr/bin/"
  ]; # }}}
in {
  environment = {
    enableAllTerminfo = true;

    profileRelativeSessionVariables = {
      # {{{
      PATH = path;
      PYTHONDONTWRITEBYTECODE = ["true"];
    }; # }}}

    profileRelativeEnvVars = {
      # {{{
    }; # }}}

    variables = {
      # {{{
      EDITOR = "vim";
      VISUAL = "svim";
      LESS = "--save-marks --status-column --incsearch --ignore-case --status-col-width=1";
      ZIG_LOCAL_CACHE_DIR = "/tmp/$USER-zig/";
      PYTHONDONTWRITEBYTECODE = "false";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
      NIXPKGS_ALLOW_UNFREE = "1";
    }; # }}}

    sessionVariables = {
      # {{{
      PATH = path;
      XDG_CACHE_HOME = "$HOME/.cache/";
      XDG_CONFIG_HOME = "$HOME/.config/";
      XDG_BIN_HOME = "$HOME/.local/bin/";
      JULIA_EDITOR = "ssvim";
      LD_LIBRARY_PATH =
        [
          # {{{
          "/run/opengl-driver/lib"
        ] # }}}
        ++ [
          (pkgs.lib.makeLibraryPath
            (with pkgs; [
              # {{{
              zlib
              stdenv.cc.cc.lib
            ])) # }}}
        ];
    }; # }}}

    # {{{
    binsh = "${pkgs.dash}/bin/dash";
    homeBinInPath = true;
    localBinInPath = true;
    # }}}

    interactiveShellInit =
      # {{{
      ''
      '';
    # }}}

    loginShellInit =
      # {{{
      ''
      '';
    # }}}

    shellAliases = {
      # {{{
      ll = "ls -la";
      nv = "nvim";
      npr = "nix repl --expr 'import <nixpkgs> {}'";
      nur = "nix repl --expr 'import <unstable> {}'";
    }; # }}}

    extraInit =
      # {{{
      ''
      '';
    # }}}

    extraSetup =
      # {{{
      ''
      '';
    # }}}

    etc = let
      # {{{
      json = pkgs.formats.json {};
      # }}}
    in {
      # {{{
      "mpv/mpv.conf" = {
        text = ''
          # for osc extension
          osc=no
        '';
        mode = "444";
      };
    }; # }}}
  };
  # {{{
  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "Europe/Warsaw";
  # }}}

  console = {
    # {{{
    font = "Lat2-Terminus16";
    #    keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  }; # }}}

  fonts.packages = with pkgs; [
    # {{{
    meslo-lgs-nf
    meslo-lg
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    liberation_ttf
  ]; # }}}

  qt = {
    # {{{
    style = "gtk2";
    platformTheme = "gtk2";
  }; # }}}

  users = {
    # {{{
    defaultUserShell = pkgs.unstable.bashInteractive;
    enforceIdUniqueness = true;

    users.test = {
      # {{{
      isNormalUser = true;
      shell = pkgs.unstable.zsh;
      # shell = config.users.defaultUserShell;
      group = "users";
      extraGroups = [];
    }; # }}}

    # done in other places
    groups = {
    };
  }; # }}}

  xdg = {
    mime = {
      # {{{
      # TODO ???
      # probably undoable anyway
      # at least in bigger amounts
      defaultApplications = let
        defBrowser = "firefox.desktop";
      in {
        # {{{
        "application/pdf" = "zathura.desktop";
        "text/html" = defBrowser;

        "x-scheme-handler/http" = defBrowser;
        "x-scheme-handler/https" = defBrowser;
        "x-scheme-handler/about" = defBrowser;
        "x-scheme-handler/unknown" = "";

        "image/png" = [
          "feh.desktop"
          "sxiv.desktop"
        ];
      }; # }}}
    }; # }}}
  };
}
