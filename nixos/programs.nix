# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  # config,
  # option,
  ...
}: {
  programs = {
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;

    # {{{
    adb.enable = true;
    ccache.enable = true;
    nix-ld.enable = true;
    xfconf.enable = true;
    command-not-found.enable = true;
    # }}}

    gnupg = {
      # {{{
      agent = {
        # {{{
        enable = true;
        # enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-gtk2;

        settings = {
          # {{{
        }; # }}}
      }; # }}}
    }; # }}}

    ssh = {
      # {{{
      agentTimeout = "90m";
      # forwardX11 = true;
      startAgent = true;

      extraConfig =
        # {{{
        '''';
      # }}}
    }; # }}}

    bash = {
      # {{{

      completion = {
        enable = true;
      };
      enableLsColors = true;

      interactiveShellInit =
        # {{{
        ''
          . ${pkgs.pass.extensions.pass-otp}/share/bash-completion/completions/pass-otp

          # z.lua or plain old z as fallback
          if whichp z.lua &>/dev/null; then
              # {{{ Because doing this normal way messes $?
              # It is exported as $EXIT
              TEMP="$(mktemp)"
              z.lua --init bash once enhanced echo fzf >"$TEMP"
              patch "$TEMP" .bash_zlua_patch &>/dev/null
              eval "$(cat $TEMP)"
              rm "$TEMP"
              TEMP=
          # }}}
          elif whichp z &>/dev/null; then
              . "$(whichp z)"
          fi
          __Z_INITIALIZED=1

        ''; # }}}

      loginShellInit =
        # {{{
        ''
        ''; # }}}

      promptInit =
        # {{{
        ''
        ''; # }}}

      shellInit =
        # {{{
        ''

          # Just in case
          conditional_source () {
            [ -f "$1" ] && source "$1"
          }

        ''; # }}}

      #
    }; # }}}

    zsh = {
      # {{{

      # {{{
      enable = true;
      enableLsColors = true;
      histSize = 10000;
      # WTF this does
      enableCompletion = true;
      enableBashCompletion = true;
      enableGlobalCompInit = false;
      # }}}

      autosuggestions = {
        # {{{
        enable = true;
        strategy = ["completion" "match_prev_cmd"];
      }; # }}}

      syntaxHighlighting = {
        # {{{
        enable = true;

        highlighters = [
          # {{{
          "main"
          "brackets"
          "regexp"
          "pattern"
        ]; # }}}
      }; # }}}

      setOptions = [
        # {{{
        "HIST_SAVE_NO_DUPS"
        "HIST_REDUCE_BLANKS"
        "HIST_FCNTL_LOCK"
        "EXTENDED_HISTORY"
        "INC_APPEND_HISTORY"
      ]; # }}}

      # This slows down zsh at least 100ms
      # This should be replaced by some flake
      # and home manager magic
      promptInit =
        # {{{
        ''
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        '';
      # }}}

      interactiveShellInit =
        # {{{
        ''
          # Done by configuration option
          __BASH_COMPINIT_RUN=1

          bindkey -e
          export WORDCHARS='%~!?+'
          ZSH_AUTOSUGGEST_USE_ASYNC='true'
          SAVEHIST=5000

          zmodload -i zsh/complist

          zstyle ':completion:*' use-cache on
          zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zscompcache"

          # TODO B this shit simply can't work
          # nix completion
          __NIX_COMP_PATH="${pkgs.unstable.nix-zsh-completions}/share/zsh"
          fpath=("$__NIX_COMP_PATH/site-functions" $fpath)
          __NIXFILE="$__NIX_COMP_PATH/plugins/nix/nix-zsh-completions.plugin.zsh"
          source "$__NIXFILE"

          # good stuff
          zstyle ':completion:*' menu select
          zstyle ':completion:*' verbose yes

          # colors files until they have common prefix
          zstyle -e ':completion:*:default' list-colors 'reply=("''${PREFIX:+=(#bi)($PREFIX:t)(?)*==35=35;01}:''${(s.:.)LS_COLORS}")';

          # smart case baby
          zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

          # zstyle :compinstall filename '~/.zshrc'
          # zstyle :compinstall filename '/etc/zshrc'

          # this slows zsh down ~50ms
          # autoload -U compinit
          # compinit
          __COMPINIT_RUN=1
        '';
      # }}}

      shellInit =
        # {{{
        ''

          # Just in case
          conditional_source () {
            [ -f "$1" ] && source "$1"
          }

        '';
      # }}}
    }; # }}}

    tmux = {
      # {{{
      enable = true;
      clock24 = true;
      historyLimit = 10000;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      terminal = "tmux-direct";

      extraConfig =
        # {{{
        let
          prefix = "M-Space";
        in ''
          unbind C-b
          unbind "${prefix}"
          set -g prefix "${prefix}"
          bind "${prefix}" send-prefix
        '';
      # }}}
    }; # }}}

    xss-lock = {
      # {{{
      enable = true;
      lockerCommand = "${pkgs.xlockmore}/bin/xlock";

      # extraOptions = [
      #   ""
      # ];
    }; # }}}

    java = {
      # {{{
      enable = true;
      package = pkgs.jdk;
    }; # }}}

    # TODO B download database somehow
    # https://github.com/nix-community/nix-index
    # https://github.com/nix-community/nix-index-database
    nix-index = {
      # {{{
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
    }; # }}}

    direnv = {
      # {{{
      enable = true;
      # silent = true;
      nix-direnv = {
        enable = true;
      };
    }; # }}}

    git = {
      # {{{
      enable = true;
      prompt.enable = true;
      package = pkgs.gitFull;

      config = {
        init = {
          # {{{
          defaultBranch = "master";
        }; # }}}
        url = {
          # {{{
          "https://github.com/" = {insteadOf = ["gh:" "github:"];};
          "https://gitlab.com/" = {insteadOf = ["gl:" "gitlab:"];};
        }; # }}}
      };
    }; # }}}

    neovim = {
      # {{{
      enable = true;
      package = pkgs.neovim-unwrapped;
      # configure = {};
      # runtime = {};
    }; # }}}
  };
}
