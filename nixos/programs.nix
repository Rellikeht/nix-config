# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  config,
  # option,
  ...
}: {
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
      enableLsColors = true;
      histSize = 2000;
      enableCompletion = false; # enabled in init section
      enableBashCompletion = true;

      autosuggestions = {
        enable = true;
        strategy = ["completion" "history" "match_prev_cmd"];
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
        "HIST_SAVE_NO_DUPS"
        "HIST_REDUCE_BLANKS"
        "HIST_FCNTL_LOCK"
        "EXTENDED_HISTORY"
        # "SHARE_HISTORY"
        "INC_APPEND_HISTORY"
      ];

      # This slows down zsh at least 100ms
      # This should be replaced by some flake
      # and home manager magic
      promptInit = ''
        source ${pkgs.unstable.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      '';

      shellInit = ''
        # Done by configuration option
        __BASH_COMPINIT_RUN=1

        bindkey -e
        export WORDCHARS='%~!?+'
        ZSH_AUTOSUGGEST_USE_ASYNC='true'
        SAVEHIST=5000

        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zscompcache"

        zstyle :compinstall filename '~/.zshrc'
        zstyle :compinstall filename '/etc/zshrc'

        # this slows zsh down ~50ms
        autoload -Uz compinit
        compinit
        __COMPINIT_RUN=1

        # Just in case
        conditional_source () {
          [ -f "$1" ] && source "$1"
        }
      '';

      interactiveShellInit = ''
      '';
    };

    tmux = {
      enable = true;
      clock24 = true;
      historyLimit = 10000;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      terminal = "tmux-direct";

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

      # extraOptions = [
      #   ""
      # ];
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
      package = pkgs.neovim-unwrapped;
      # configure = {};
      # runtime = {};
    };
  };
}
