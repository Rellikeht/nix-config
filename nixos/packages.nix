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
  perlProv = perl538;
  perlPkgs = perl538Packages;
  #perlPkgs = perlProv.pkgs;
  # }}}

  # {{{ python
  newestPython = python313;
  pythonProv = python312;
  # oldPython = python311;
  pythonPackages = ps:
    with ps; [
      # {{{
      bpython
      pip
      python-lsp-server
      pylsp-mypy
      mypy
      pynvim

      mdformat
      gdown
    ]; # }}}

  myPython = pythonProv.withPackages pythonPackages;
  # }}}

  # {{{ lua
  luaCommonPkgs = ps:
    with ps; [
      # {{{
      luacheck
      luautf8
      luafilesystem
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

  system-utils = with pkgs; [
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
  ]; # }}}

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

      # TODO
      # nixops_unstable_full

      alejandra
      nil
    ] # }}}
    ++ (with unstable; [
      # {{{
      # nixd
    ])); # }}}

  tty-utils = with pkgs; [
    # {{{
    physlock
  ]; # }}}

  secrets = with pkgs; [
    # {{{
    gpgme
    gpg-tui

    pass
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

      # syncthing
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
      transmission

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
      fzy
      rlwrap

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
      (lib.setPrio 100 moreutils)
      (lib.setPrio 200 parallel)
      (
        pkgs.writeScriptBin
        "mparallel"
        ''exec ${moreutils}/bin/parallel $@''
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
      help2man
      # }}}
    ]
    ++ (with unstable; [
      # {{{
      fzf
      dash

      # ???
      zsh-completions
      zsh-you-should-use
      nix-zsh-completions

      z-lua
    ]); # }}}

  shell-libs = with pkgs; [
    # {{{
    gnum4
    xxh
    zlib
    pcre
    tre
    iconv
    readline
  ]; # }}}

  shell-graphics = with pkgs; [
    # {{{
    cmatrix
    tmatrix

    delta

    fastfetch
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
      (lib.setPrio 200 vim)
      kakoune
      kak-lsp
      vis

      emacs
    ]
    ++ (with unstable; [
      neovim
      neovim-qt
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
    # unrar-free

    # archivemount
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
    ] # }}}
    ++ (with unstable;
      [
        # {{{
        sddm-chili-theme
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
    firefox
    ungoogled-chromium
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

  audio-downloaders = with pkgs; [
    # {{{
    yt-dlp
    spotdl
  ]; # }}}

  # CODE

  code = with pkgs;
    [
      # {{{
      sbcl
      clisp
      guile
      (lib.setPrio 150 (lua5_4.withPackages luaPkgs))
      (lib.setPrio 100 (luajit.withPackages luajitPkgs))
      gforth
      tcl

      gcc
      clang
      ghc
      nickel

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
        # dhall-lsp-server

        gopls
        nimlsp
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
          # dhall
          # dhall-yaml
          # dhall-nix
          # dhall-json
          # dhall-toml
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
    libqalculate
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

      # TODO when this shit will work
      # typst-lsp
    ] # }}}
    ++ (with unstable; [
      # {{{
      typst
      typstfmt
      typst-live

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
    # TODO vim tiny
    st
    dwm
    dmenu
    tabbed

    (lib.setPrio 200 svim)
    breeze-hacked
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
# TODO smapi - battery, proper linux for that

