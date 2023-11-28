# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

{ pkgs, config, option, ... }:
let

in

{

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

    command-not-found.enable = true;
#    command-not-found.enable = false;

# TODO download database somehow
# https://github.com/nix-community/nix-index
# https://github.com/nix-community/nix-index-database
    nix-index = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
    };

  };

}

