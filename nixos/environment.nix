# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{pkgs, ...}: let
  b = builtins;

  defBrowser = "firefox.desktop";
  path = [
    "/usr/bin/"
  ];
in rec {
  environment = {
    enableAllTerminfo = true;

    profileRelativeSessionVariables = {
      PATH = path;
      PYTHONDONTWRITEBYTECODE = ["true"];
    };

    profileRelativeEnvVars = {
      #      PATH = path;
    };

    variables = {
      EDITOR = "vim";
      VISUAL = "svim";
      LESS = "--save-marks --status-column --incsearch --ignore-case";
      ZIG_LOCAL_CACHE_DIR = "/tmp/$USER-zig/";
      PYTHONDONTWRITEBYTECODE = "false";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
      NIXPKGS_ALLOW_UNFREE = "1";
    };

    sessionVariables = {
      PATH = path;
      XDG_CACHE_HOME = "$HOME/.cache/";
      XDG_CONFIG_HOME = "$HOME/.config/";
      XDG_BIN_HOME = "$HOME/.local/bin/";
      JULIA_EDITOR = "ssvim";
    };

    binsh = "${pkgs.dash}/bin/dash";
    homeBinInPath = true;
    localBinInPath = true;

    interactiveShellInit = ""; # TODO
    loginShellInit = ""; # TODO

    shellAliases = {
      ll = "ls -la";
      nv = "nvim";
      npr = "nix repl --expr 'import <nixpkgs> {}'";
    };

    # TODO needed directories and symlinks
    extraInit = "";
    extraSetup = "";

    etc = {};
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "Europe/Warsaw";

  console = {
    font = "Lat2-Terminus16";
    #    keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  fonts.packages = with pkgs; [
    meslo-lgs-nf
    meslo-lg
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    liberation_ttf
  ];

  qt = {
    style = "gtk2";
    platformTheme = "gtk2";
  };

  users = {
    defaultUserShell = pkgs.zsh;
  };

  systemd = {
    ctrlAltDelUnit = "";
    extraConfig = "
      DefaultTimeoutStopSec=15s
    ";
  };

  users = {
    enforceIdUniqueness = true;

    users.test = {
      isNormalUser = true;
      shell = pkgs.zsh;
      group = "users";
    };

    groups = {
      #      "name" = {
      #        gid = 0;
      #        name = "name";
      #      };
    };
  };

  xdg = {
    mime = {
      defaultApplications = {
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
      };
    };
  };
}
# TODO cursor
# TODO rc files

