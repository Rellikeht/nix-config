# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  config,
  ...
}:
with pkgs; let
  # b = builtins;
  perlProv = perl538;
  perlPkgs = perl538Packages;
  #perlPkgs = perlProv.pkgs;

  #  pythonPackage = python311Full;
  #  pythonOverride = pythonPackage.override {
  #    enableOptimizations = true;
  #    reproducibleBuild = false;
  #    self = pythonOverride;
  #  };
  #  pyOverPkgs = pythonOverride.pkgs;

  #  pythonOptimized = pythonOverride.pkgs.buildPythonPackage rec {
  #    name = "python-example";
  #    #inherit src;
  #    propagatedBuildInputs = with pyOverPkgs; [
  #      numpy
  #    ];
  #    nativeBuildInputs = with pyOverPkgs;
  #      pkgs.lib.optionals (pkgs.lib.inNixShell) [
  #        ipython
  #      ];
  #  };

  # Optimized python should be done separately
  # and built on remote server
  #pythonProv = pythonOptimized;
  # This at least doesn't rebuild fucking everything
  # From fucking source
  newestPython = python313;
  pythonProv = python311;
  # oldPython = python312;
  pythonPackages = ps:
    with ps; [
      bpython
      pip
      python-lsp-server
      pylsp-mypy
      mypy
      pynvim
      mdformat
    ];

  myPython = pythonProv.withPackages pythonPackages;

  # SYSTEM

  system-libs = with pkgs; [
    procps
    lm_sensors
    util-linux
    usbutils
    psmisc
    mesa
    libuuid
  ];

  system-utils = with pkgs; [
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
  ];

  filesystems = with pkgs; [
    e2fsprogs
    ntfs3g

    sshfs
    davfs2

    adbfs-rootless
    #   adb-sync #?
  ];

  nix-utils = with pkgs; ([
      home-manager.home-manager

      nix-zsh-completions
      nix-bash-completions
      zsh-nix-shell
      nix-du
      nix-top
      nix-tree
      nix-search-cli
      nix-script
      nixos-shell
      nixopsUnstable
      comma
      nix-index
      patchelf

      alejandra
      nil
    ]
    ++ (with unstable; [
      # Needs outdated nix with cve :(
      # nixd
    ]));

  tty-utils = with pkgs; [
    physlock
  ];

  secrets = with pkgs; [
    gpgme
    gpg-tui

    pass
    keepassxc
    keepass-diff
    keepmenu
    kpcli
  ];

  # NETWORK

  network-utils = with pkgs; ([
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
    ]
    ++ (with unstable; [
      # syncthing
      stc-cli
    ]));

  network-programs = with pkgs;
    [
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
      # transmission-gtk
    ]
    ++ (with unstable; [
      gdown # temporary ???
    ]);

  # BASIC

  shell-utils = with pkgs; [
    dash
    # ???
    zsh-completions
    zsh-you-should-use

    fzf
    fzy
    rlwrap

    screen
    less
    bat
    file

    time
    progress
    pv

    parallel
    findutils
    coreutils-full

    gnugrep
    silver-searcher

    bc
    gnused
    gawk

    man
    man-pages
    linux-manual
    stdman
    help2man
  ];

  shell-libs = with pkgs; [
    gnum4
    xxh
    zlib
    pcre
    tre
    iconv
    readline
  ];

  shell-graphics = with pkgs; [
    cmatrix
    tmatrix

    delta

    neofetch
    fastfetch
    tree

    fortune
    figlet
    lolcat
  ];

  terminals = with pkgs; ([
      rxvt-unicode-emoji
    ]
    ++ (
      with unstable; [
        alacritty
      ]
    ));

  editors = with pkgs; [
    ed
    vim
    neovim
    kakoune
    vis

    emacs
    neovim-qt
  ];

  # FILES

  file-management = with pkgs; [
    vifm
    ranger
    stow
  ];

  archives = with pkgs; [
    xarchiver

    gnutar
    xz

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
  ];

  fsys-utils = with pkgs; [
    fdupes
    plocate

    gparted
    gpart
    parted
  ];

  # GRAPHICAL

  xorg = with pkgs.xorg; [
    xmodmap
    xinit
    xev
    xrandr
    xrdb
  ];

  x-utils = with pkgs; [
    brightnessctl

    xlockmore
    xss-lock
    xautolock

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

    rofi
    rofi-pass
  ];

  graphics = with pkgs; [
    imagemagickBig
    graphicsmagick
    pinta
  ];

  viewers = with pkgs; [
    feh
    sxiv
  ];

  themes = with pkgs; ([
      arc-theme
      materia-theme
      sddm-chili-theme
      papirus-icon-theme
    ]
    ++ (with unstable;
      [
      ]
      ++ (with haskellPackages; [
        # FractalArt
      ])));

  fonts = with pkgs; [
    fontconfig
    freetype
    font-awesome
  ];

  documents = with pkgs; [
    ghostscript
    pdfgrep

    zathura
    mupdf
  ];

  browsers = with pkgs; [
    qutebrowser
    firefox
    ungoogled-chromium
  ];

  # AUDIO

  audio-libs = with pkgs; [
    alsa-utils
  ];

  audio-utils = with pkgs; (
    [
      pulsemixer
      alsa-tools # ?
      # pipecontrol
      pavucontrol

      playerctl
    ]
    ++ (with xfce; [
      xfce4-volumed-pulse
      xfce4-pulseaudio-plugin
      xfce4-timer-plugin
    ])
  );

  audio-programs = with pkgs; (
    [
      mpv
      vlc

      ytfzf

      ffmpeg-full
      mediainfo
    ]
    ++ (with unstable; [
      ])
  );

  audio-downloaders = with pkgs; [
    yt-dlp
    spotdl
  ];

  # CODE

  code = with pkgs;
    [
      sbcl
      clisp
      guile
      lua
      luajit
      gforth
      tcl

      gcc
      clang
      ghc
      nickel

      newestPython
      myPython
      perlProv
    ]
    # No idea how much of that unstables is needed
    ++ (with unstable; [
      ocaml
      go
      zig
      nim
      rustc
    ]);

  jdks = with pkgs; [
  ];

  lsps = with pkgs;
    [
      clang-tools
      lua-language-server
      nls
    ]
    ++ (with unstable;
      [
        # dhall-lsp-server

        gopls
        nimlsp
        zls
        rust-analyzer
        # unstable compiles from source and fails for now :( )
        # pylyzer
      ]
      ++ (with haskellPackages; [
        haskell-language-server
      ])
      ++ (with ocamlPackages; [
        ocaml-lsp
        ocamlformat
      ]));

  formatters = with pkgs;
    [
      cmake-format

      luaformatter
      vim-vint
      shfmt
      yamlfix
    ]
    ++ (with unstable;
      [
        rustfmt
        ruff
      ]
      ++ (with haskellPackages; [
        floskell
      ]));

  pkg-managers = with pkgs;
    [
      opam
    ]
    ++ (with unstable; [
      nimble
      cargo
    ]);

  builders = with pkgs; [
    gnumake
    automake
    cmake

    dune_3
  ];

  code-utils = with pkgs; ([
      git-doc
      flex
      bison
      pkg-config

      shellcheck
      checkbashisms

      gdb

      hyperfine
      config.boot.kernelPackages.perf
    ]
    ++ (with haskellPackages; [
      ])
    ++ (
      with unstable;
        [
          zig-shell-completions
        ]
        ++ (with ocamlPackages; [
          utop
        ])
        ++ (with haskellPackages; [
          # dhall
          # dhall-yaml
          # dhall-nix
          # dhall-json
          # dhall-toml
        ])
    ));

  code-libs = with pkgs; (
    [
      tclreadline
      tk
      sqlite
    ]
    ++ (with perlPkgs; [
      WWWYoutubeViewer
      TermReadLineGnu
    ])
    ++ (with unstable; ([]
      ++ (with ocamlPackages; [
        yojson
      ])
      ++ (with haskellPackages; [
        ])))
  );

  guile-libs = with pkgs; [
    guile-git
    guile-ssh
    guile-gnutls
  ];

  # OTHER

  meth = with pkgs; [
    maxima
    libqalculate
    gnuplot
  ];

  typesetting = with pkgs; (
    [
      glow
      mdr
      lowdown

      pinfo
      highlight
    ]
    ++ (with unstable; [
      typst
      typstfmt
      typst-lsp
      typst-live

      groff
    ])
  );

  scan-print = with pkgs; [
    system-config-printer
    sane-backends
    sane-frontends
  ];

  my = with pkgs.builds; [
    st
    dwm
    dmenu
    tabbed

    svim
    breeze-hacked

    # TODO this should be in system xsession settings
    # xinit-xsession
  ];

  other = with pkgs; (
    [
      mesa-demos
    ]
    ++ (with unstable; [
      # Cant download :(
      # unstable doesn't help
      # libsForQt5.xp-pen-deco-01-v2-driver
    ])
  );
in {
  environment.systemPackages =
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

  environment.variables = {
  };
}
# TODO smapi - battery, proper linux for that

