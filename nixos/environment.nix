# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{pkgs, ...}: let
  # b = builtins;
  path = [
    "/usr/bin/"
  ];
in {
  environment = {
    enableAllTerminfo = true;

    profileRelativeSessionVariables = {
      PATH = path;
      PYTHONDONTWRITEBYTECODE = ["true"];
    };

    profileRelativeEnvVars = {
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
      LD_LIBRARY_PATH = ["/run/opengl-driver/lib"];
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
      nur = "nix repl --expr 'import <unstable> {}'";
    };

    # TODO needed directories and symlinks
    extraInit = "";
    extraSetup = "";

    etc = let
      json = pkgs.formats.json {};
    in {
      # # TODO 24.05 will give this own option
      # "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      #   bluez_monitor.properties = {
      #   	["bluez5.enable-sbc-xq"] = true,
      #   	["bluez5.enable-msbc"] = true,
      #   	["bluez5.enable-hw-volume"] = true,
      #   	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      #   }
      # '';

      # "pipewire/pipewire.d/92-low-latency.conf".source = json.generate "92-low-latency.conf" {
      #   context = {
      #     properties = {
      #       default.clock.rate = 48000;
      #       default.clock.quantum = 32;
      #       default.clock.min-quantum = 16;
      #       default.clock.max-quantum = 32;
      #     };
      #     modules = [
      #       {
      #         name = "libpipewire-module-protocol-pulse";
      #         args = {
      #           pulse.min.req = "32/48000";
      #           pulse.default.req = "32/48000";
      #           pulse.max.req = "32/48000";
      #           pulse.min.quantum = "16/48000";
      #           pulse.max.quantum = "32/48000";
      #         };
      #       }
      #     ];
      #     stream.properties = {
      #       node.latency = "32/48000";
      #       resample.quality = 1;
      #     };
      #   };
      # };
    };
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
    defaultUserShell = pkgs.unstable.zsh;
    enforceIdUniqueness = true;

    users.test = {
      isNormalUser = true;
      shell = pkgs.zsh;
      group = "users";
      extraGroups = [];
    };

    # done in other places
    groups = {
    };
  };

  xdg = {
    mime = {
      # TODO ???
      # probably undoable anyway
      # at least in bigger amounts
      defaultApplications = let
        defBrowser = "firefox.desktop";
      in {
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
