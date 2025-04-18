# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs, # {{{
  config,
  ...
  # }}}
}:
with pkgs; let
  # {{{
  b = builtins;
  # }}}

  # {{{
  perlProv = perl540;
  perlPkgs = perl540Packages;
  # }}}

  # {{{ python
  newestPython = python314;
  pythonProv = python312;
  # oldPython = python311;

  pythonPackages = ps:
    with ps; [
      # {{{
      bpython
      pip
      uv
      python-lsp-server
      # pylsp-mypy
      # mypy
      pynvim
      gdown

      # mdformat
      # mdformat-gfm
      # mdformat-tables

      # ??
      # mdformat-toc
      # mdformat-mkdocs
    ]; # }}}

  myPython = pythonProv.withPackages pythonPackages;
  # }}}

  # {{{ lua
  luaCommonPkgs = ps:
    with ps; [
      # {{{
      lua
      luacheck
      luautf8
      luafilesystem
      luaformatter
    ]; # }}}

  luajitPkgs = ps:
    luaCommonPkgs ps
    ++ (with ps; [
      # {{{
      magick
    ]); # }}}

  luaPkgs = ps:
    luaCommonPkgs ps
    ++ (with ps; [
      # {{{
    ]); # }}}
  # }}}

  # SYSTEM

  system-libs = with pkgs; [
    # {{{
    procps
    lm_sensors
    util-linux
    usbutils
    psmisc
    mesa
    libuuid
  ]; # }}}

  system-utils = with pkgs;
    [
      # {{{
      v4l-utils

      lsof
      lshw
      acpi
      pciutils

      reptyr

      htop # got used to variant without vim bindings :(
      # htop-vim

      su
      binutils

      arch-install-scripts
      android-file-transfer
      android-tools

      appimage-run
    ]
    ++ (with nvtopPackages; [
      intel
    ]); # }}}

  filesystems = with pkgs; [
    # {{{
    e2fsprogs
    ntfs3g

    sshfs
    davfs2

    adbfs-rootless
    #   adb-sync #?
  ]; # }}}

  nix-utils = with pkgs; ([
      # {{{
      home-manager.home-manager

      zsh-nix-shell
      nix-du
      nix-top
      nix-tree
      nix-search-cli
      nix-script
      nixos-shell
      comma
      nix-index
      patchelf

      # TODO D
      # nixops_unstable_full

      alejandra
      nil
    ] # }}}
    ++ (with unstable; [
      # {{{
    ])); # }}}

  tty-utils = with pkgs; [
    # {{{
    physlock
  ]; # }}}

  secrets = with pkgs; [
    # {{{
    gpgme
    gpg-tui

    (pass.withExtensions (exts:
      with exts; [
        pass-otp
        pass-file
        pass-update
        pass-genphrase
      ]))
    keepassxc
    keepass-diff
    keepmenu
    kpcli
  ]; # }}}

  # NETWORK

  network-utils = with pkgs; ([
      # {{{
      nmap
      nettools
      iperf

      networkmanager
      networkmanager-openvpn
      openvpn

      phodav
      kubo

      cadaver
      inetutils

      dhcpcd
      wpa_supplicant

      stc-cli
    ] # }}}
    ++ (with unstable; [
      # {{{
    ])); # }}}

  network-programs = with pkgs;
    [
      # {{{
      wget
      curl
      curlie
      w3m

      aria
      lftp
      rsync

      speedtest-cli

      megatools
      rclone
      transmission_4

      dumptorrent
      gdown
    ] # }}}
    ++ (with unstable; [
      # {{{
    ]); # }}}

  # BASIC

  shell-utils = with pkgs;
    [
      # {{{
      rlwrap
      dash

      screen
      less
      bat
      file

      time
      progress
      pv
      timer

      findutils
      coreutils-full

      (parallel // {meta.priority = 4;})
      (
        pkgs.writeScriptBin
        "mparallel"
        ''exec ${moreutils}/bin/parallel "$@"''
      )

      gnugrep
      silver-searcher
      ripgrep
      ripgrep-all

      bc
      gnused
      gawk

      man
      man-pages
      linux-manual
      stdman
      tldr

      help2man
      (plan9port // {meta.priority = 6;})
      complgen
      # }}}
    ]
    ++ (with unstable; [
      # {{{
      fzf

      # ???
      zsh-completions
      zsh-you-should-use
      nix-zsh-completions

      z-lua
    ]); # }}}

  shell-libs = with pkgs; [
    # {{{
    gnum4
    xxHash
    zlib
    tre
    iconv
    readline

    pcre2
    (
      writeScriptBin "pcregrep"
      ''exec ${pcre2}/bin/pcre2grep "$@"''
    )
  ]; # }}}

  shell-graphics = with pkgs; [
    # {{{
    cmatrix
    tmatrix

    delta

    fastfetch
    onefetch
    tree

    fortune
    figlet
    lolcat
  ]; # }}}

  terminals = with pkgs; ([
      # {{{
      rxvt-unicode-emoji
      alacritty
    ] # }}}
    ++ (
      with unstable; [
        # {{{
      ] # }}}
    ));

  editors = with pkgs; ([
      # {{{
      ed
      (vim // {meta.priority = 6;})
      kakoune
      kak-lsp
      vis
      emacs

      neovim
      neovim-qt
    ]
    ++ (with unstable; [
      ])); # }}}

  # FILES

  file-management = with pkgs; [
    # {{{
    vifm
    ranger
    stow
    pcmanfm
  ]; # }}}

  archives = with pkgs; [
    # {{{
    xarchiver

    gnutar
    xz
    pixz

    p7zip
    zip
    unzip

    gzip
    bzip2
    lzip

    zstd
    arj

    rar
    unrar
    unrar-free

    archivemount
    fuse-archive
    rar2fs
  ]; # }}}

  fsys-utils = with pkgs; [
    # {{{
    fdupes
    plocate

    gparted
    gpart
    parted

    fuseiso
  ]; # }}}

  # GRAPHICAL

  xorg = with pkgs.xorg; [
    # {{{
    xmodmap
    xinit
    xev
    xrandr
    xrdb
  ]; # }}}

  x-utils = with pkgs; [
    # {{{
    brightnessctl

    xlockmore
    xss-lock

    xcape
    xclip

    xdotool
    xbindkeys
    keynav

    dzen2
    shotgun
    scrot
    slop

    unclutter
    nitrogen
    libnotify

    rofi
    rofi-pass
    xdragon
  ]; # }}}

  graphics = with pkgs; [
    # {{{
    imagemagickBig
    graphicsmagick
    pinta
  ]; # }}}

  viewers = with pkgs; [
    # {{{
    feh
    sxiv
  ]; # }}}

  themes = with pkgs; ([
      # {{{
      arc-theme
      materia-theme
      papirus-icon-theme
      breeze-hacked-cursor-theme

      # here are inserted names for use in config
      # because naming things in obvious way is too hard
      sddm-chili-theme # chili
      sddm-sugar-dark # sugar-dark
      sddm-astronaut # doesn't work
      # doesn't work, no matter "-" or "_" between words
      where-is-my-sddm-theme
    ] # }}}
    ++ (with unstable;
      [
        # {{{
      ] # }}}
      ++ (with haskellPackages; [
        # {{{
        # FractalArt
      ]))); # }}}

  fonts = with pkgs; [
    # {{{
    fontconfig
    freetype
    font-awesome
  ]; # }}}

  documents = with pkgs; [
    # {{{
    ghostscript
    pdfgrep

    zathura
    mupdf
  ]; # }}}

  browsers = with pkgs; [
    # {{{
    vimb
    luakit
    qutebrowser
    librewolf
    ungoogled-chromium
    brave
  ]; # }}}

  # AUDIO

  audio-libs = with pkgs; [
    # {{{
    alsa-utils
  ]; # }}}

  audio-utils = with pkgs; (
    [
      # {{{
      pulsemixer
      alsa-tools # ?
      # pipecontrol
      pavucontrol

      playerctl
    ] # }}}
    ++ (with xfce; [
      # {{{
      xfce4-volumed-pulse
      xfce4-pulseaudio-plugin
      xfce4-timer-plugin
    ]) # }}}
  );

  audio-programs = with pkgs; (
    [
      # {{{
      mpv
      vlc

      ytfzf

      ffmpeg-full
      mediainfo
    ] # }}}
    ++ (with unstable; [
      # {{{
    ]) # }}}
  );

  audio-downloaders = with pkgs;
    [
      # {{{
      spotdl
    ]
    ++ (with unstable; [
      yt-dlp
    ]); # }}}

  # CODE

  code = with pkgs; let
    luap = lua5_4.withPackages luaPkgs;
    cc = c:
      if (c == "+" || c == "-" || c == "." || c == "_")
      then ""
      else c;
    name =
      lib.concatStrings
      (map cc (lib.stringToCharacters luap.lua.luaAttr));
    luawrap = writeScriptBin name ''
      exec ${luap}/bin/lua "$@"
    '';
  in
    [
      # {{{
      sbcl
      clisp
      guile
      gforth
      tcl

      (luajit.withPackages luajitPkgs
        // {
          meta.priority =
            6;
        })
      (luap // {meta.priority = 4;})
      luawrap

      gcc
      clang
      ghc

      newestPython
      myPython
      perlProv
    ] # }}}
    # No idea how much of that unstables is needed
    ++ (with unstable; [
      # {{{
      ocaml
      go
      zig
      nim
      rustc

      universal-ctags
    ]); # }}}

  jdks = with pkgs; [
    # {{{
  ]; # }}}

  lsps = with pkgs;
    [
      # {{{
      lua-language-server
      nls
    ] # }}}
    ++ (with unstable;
      [
        # {{{
        clang-tools

        gopls
        nimlangserver
        zls
        rust-analyzer
        pylyzer
      ] # }}}
      ++ (with haskellPackages; [
        # {{{
        haskell-language-server
      ]) # }}}
      ++ (with ocamlPackages; [
        # {{{
        ocaml-lsp
        ocamlformat
      ])); # }}}

  formatters = with pkgs;
    [
      # {{{
      cmake-format

      luaformatter
      vim-vint
      shfmt
      yamlfix
    ] # }}}
    ++ (with unstable;
      [
        # {{{
        rustfmt
        ruff
      ] # }}}
      ++ (with haskellPackages; [
        # {{{
        floskell
      ])); # }}}

  pkg-managers = with pkgs;
    [
      # {{{
    ] # }}}
    ++ (with unstable; [
      # {{{
      opam
      nimble
      cargo
    ]); # }}}

  builders = with pkgs; [
    # {{{
    gnumake
    automake
    autoconf
    cmake

    dune_3
  ]; # }}}

  code-utils = with pkgs; ([
      # {{{
      git-doc
      flex
      bison
      pkg-config

      shellcheck
      checkbashisms

      gdb

      hyperfine
      config.boot.kernelPackages.perf
      zig-shell-completions
    ] # }}}
    ++ (with haskellPackages; [
      # {{{
    ]) # }}}
    ++ (
      with unstable;
        [
          # {{{
        ] # }}}
        ++ (with ocamlPackages; [
          # {{{
          utop
        ]) # }}}
        ++ (with haskellPackages; [
          # {{{
        ]) # }}}
    ));

  code-libs = with pkgs; (
    [
      # {{{
      tclreadline
      tk
      sqlite
    ] # }}}
    ++ (with perlPkgs; [
      # {{{
      WWWYoutubeViewer
      TermReadLineGnu
    ]) # }}}
    ++ (with unstable; ([
        # {{{
      ] # }}}
      ++ (with ocamlPackages; [
        # {{{
        yojson
      ]) # }}}
      ++ (with haskellPackages; [
        # {{{
      ]))) # }}}
  );

  guile-libs = with pkgs; [
    # {{{
    guile-git
    guile-ssh
    guile-gnutls
  ]; # }}}

  # OTHER

  meth = with pkgs; [
    # {{{
    maxima
    # libqalculate
    gnuplot
  ]; # }}}

  typesetting = with pkgs; (
    [
      # {{{
      glow
      mdr
      lowdown

      pinfo
      highlight

      tinymist
    ] # }}}
    ++ (with unstable; [
      # {{{
      typst
      typstfmt
      # prettypst

      groff
    ]) # }}}
  );

  scan-print = with pkgs; [
    # {{{
    system-config-printer
    sane-backends
    sane-frontends
  ]; # }}}

  my = with pkgs.builds; [
    # {{{
    # TODO D vim tiny
    st
    dwm
    dmenu
    tabbed

    (svim // {meta.priority = 4;})
  ]; # }}}

  other = with pkgs; (
    [
      # {{{
      mesa-demos
      libsForQt5.xp-pen-deco-01-v2-driver
    ] # }}}
    ++ (with unstable; [
      # {{{
    ]) # }}}
    ++ (with nodePackages; [
      #  {{{
      # prettier
    ]) #  }}}
  );
in {
  environment.systemPackages =
    # {{{
    system-libs
    ++ system-utils
    ++ filesystems
    ++ nix-utils
    ++ tty-utils
    ++ secrets
    ++ network-utils
    ++ network-programs
    ++ shell-utils
    ++ shell-libs
    ++ shell-graphics
    ++ terminals
    ++ editors
    ++ file-management
    ++ archives
    ++ fsys-utils
    ++ xorg
    ++ x-utils
    ++ graphics
    ++ viewers
    ++ themes
    ++ fonts
    ++ documents
    ++ browsers
    ++ audio-libs
    ++ audio-utils
    ++ audio-programs
    ++ audio-downloaders
    ++ code
    ++ jdks
    ++ lsps
    ++ formatters
    ++ pkg-managers
    ++ builders
    ++ code-utils
    ++ code-libs
    ++ guile-libs
    ++ meth
    ++ typesetting
    ++ scan-print
    ++ my
    ++ other;
  # }}}

  environment.variables = {
    # {{{
  }; # }}}
}
