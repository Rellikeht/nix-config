# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

{ pkgs, config, option, ... }:
let
pkgImport = import ./pkgs.nix;

in
with pkgImport;

{
#  inherit pkgs unstable oldRel;

  programs = {

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryFlavor = "gtk2";
      };
    };

    xfconf.enable = true;

    zsh = {
      enable = true;
      enableBashCompletion = true;

      autosuggestions = {
        enable = true;
        strategy = ["completion" "history"];

      };

      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
          "regexp"
#          "root"
          "pattern"
        ];
      };

      setOptions = [
        "HIST_IGNORE_DUPS"
        "HIST_FCNTL_LOCK"
      ];

      interactiveShellInit = "
        bindkey -e
        [ -e ~/.zshrc ] && source ~/.zshrc
      ";

    };

    tmux = {
      enable = true;
      clock24 = true;
      historyLimit = 10000;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      shortcut = "q";
      terminal = "tmux-direct";
    };

    adb.enable = true;
    ccache.enable = true;
    nix-ld.enable = true;

    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.xlockmore}/bin/xlock";

#      extraOptions = [
#        ""
#      ];

    };

    java = {
      enable = true;
      package = pkgs.jdk17;
    };

    command-not-found.enable = false;
    nix-index = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

  };

}

