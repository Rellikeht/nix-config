# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  config,
  option,
  ...
}: let
in {
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
        strategy = ["completion" "history" "match_prev_cmd"];
      };

      syntaxHighlighting = {
        enable = true;
        highlighters = [
          # bad root

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

      #      interactiveShellInit = "
      shellInit = "
        bindkey -e
        [ -e ~/.zshrc ] && source ~/.zshrc
        export WORDCHARS='%~!?+'

#        my-backward-delete-word () {
#           local WORDCHARS='~!#$%^*<>?+/'
#           zle backward-delete-word
#        }
#        zle -N my-backward-delete-word
#        bindkey    '\\e^?' my-backward-delete-word

        conditional_source () {
          [ -f \"\$1\" ] && source \"\$1\"
        }

        conditional_source \"/etc/.aliasrc\"
        conditional_source \"\$HOME/.aliasrc\"
        conditional_source \"/etc/.funcrc\"
        conditional_source \"\$HOME/.funcrc\"
        conditional_source \"/etc/.varrc\"
        conditional_source \"\$HOME/.varrc\"
      ";
    };

    tmux = {
      enable = true;
      clock24 = true;
      historyLimit = 10000;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      terminal = "tmux-direct";
      #shortcut = "q";

      extraConfig = let
        prefix = "M-Space";
      in ''
        unbind C-b
        unbind "${prefix}"
        set -g prefix "${prefix}"
        bind "${prefix}" send-prefix
      '';
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

    # ???
    java = {
      enable = true;
      package = pkgs.jdk; #17;
    };

    command-not-found.enable = true;

    # TODO download database somehow
    # https://github.com/nix-community/nix-index
    # https://github.com/nix-community/nix-index-database
    nix-index = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
      # silent = true;
    };

    git = {
      enable = true;
      prompt.enable = true;
      package = pkgs.gitFull;

      # TODO more config
      config = {
        init = {
          defaultBranch = "master";
        };
        url = {
          "https://github.com/" = {insteadOf = ["gh:" "github:"];};
          "https://gitlab.com/" = {insteadOf = ["gl:" "gitlab:"];};
        };
      };
    };

    neovim = {
      enable = true;

      # TODO ?
      #      configure = {};
      #      runtime = {};
    };
  };
}
