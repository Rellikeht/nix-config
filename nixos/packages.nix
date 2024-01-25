# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  config,
  ...
}:
with pkgs; let
  #  unstable = unstable;
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

  #pythonProv = pythonOptimized;
  # This at least doesn't rebuild fucking everything
  # From fucking source
  pythonProv = python311;
  pythonPackages = ps:
    with ps; [
      bpython
      pip
      python-lsp-server
      pynvim
    ];

  myPython = pythonProv.withPackages pythonPackages;
  newestPython = unstable.python313;
in {
  environment.systemPackages = with pkgs; [
    home-manager.home-manager

    vim
    neovim-qt
    kakoune
    vis

    vifm
    ranger
    fdupes
    stow

    unstable.groff
    glow
    mdp
    mdr
    lowdown
    pinfo
    highlight

    screen
    physlock
    procps
    lm_sensors
    htop
    #    htop-vim

    gnumake
    gnum4
    automake
    cmake
    flex
    bison
    rlwrap

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
    #    nixfmt
    nixpkgs-fmt
    alejandra

    sbcl
    clisp
    guile
    lua
    luajit
    gforth
    tcl
    tclreadline
    tk
    maxima
    libqalculate
    gnuplot

    gcc
    jdk

    unstable.go
    unstable.gopls

    unstable.zig
    unstable.zls
    unstable.zig-shell-completions

    unstable.nim
    unstable.nimble
    unstable.nimlsp

    unstable.rustc
    unstable.rustfmt
    unstable.rust-analyzer

    unstable.ghc
    unstable.haskell-language-server

    unstable.nil
    unstable.nixd

    ocaml
    opam
    ocamlPackages.utop
    ocamlPackages.ocaml-lsp

    udunits
    clang-tools
    lua-language-server
    vim-vint
    shellcheck
    checkbashisms

    zsh-completions
    zsh-syntax-highlighting
    zsh-powerlevel10k
    dash
    tre
    fzf
    fzy

    bc
    ed
    gnused
    gawk
    man
    coreutils-full
    lsof
    gnugrep
    time
    less
    psmisc
    zlib
    pkg-config
    reptyr
    parallel-full
    xxh
    pcre

    e2fsprogs
    util-linux
    os-prober
    help2man
    v4l-utils

    gnutar
    p7zip
    zip
    unzip
    xz
    gzip
    bzip2
    zstd
    arj
    lzip
    rar
    unrar

    pass
    keepassxc
    dhcpcd
    wpa_supplicant
    speedtest-cli
    inetutils

    delta
    w3m
    silver-searcher
    progress
    neofetch
    tree
    plocate
    bat
    pv
    hyperfine
    config.boot.kernelPackages.perf
    #    perf-tools # ?

    mpv
    vlc
    ffmpeg
    yt-dlp
    ytfzf
    mediainfo
    file
    iconv
    spotdl

    gparted
    gpart
    parted
    pciutils
    lshw
    acpi
    libuuid
    sqlite

    xlockmore
    xss-lock
    xautolock
    fortune
    figlet
    lolcat

    qutebrowser
    firefox
    ungoogled-chromium

    brightnessctl
    alacritty
    rxvt-unicode-emoji
    feh
    sxiv
    pdfgrep
    pulsemixer
    playerctl
    alsa-utils
    alsa-tools # ?

    #    wireplumber
    #    pipecontrol
    pavucontrol

    aria
    lftp
    wget
    curl
    curlie
    rsync
    phodav
    cadaver
    megatools
    gdown
    syncthing
    rclone
    dumptorrent
    transmission
    transmission-gtk

    sshfs
    davfs2

    sddm-chili-theme
    papirus-icon-theme
    fontconfig
    freetype
    ghostscript

    # Remove when this will be added properly
    # Config must be flake probably for that
    #    dmenu
    unclutter
    dzen2
    shotgun
    scrot

    # Modes don't work
    # they probably need some overlay
    rofi
    rofi-calc
    rofi-emoji

    rofi-pass

    mesa-demos
    mesa
    xarchiver

    nitrogen
    keynav
    xcape
    xclip
    xdotool
    xbindkeys
    xorg.xmodmap
    xorg.xinit
    xorg.xev
    xorg.xrandr
    xorg.xrdb

    nmap
    nettools
    iperf

    networkmanager
    networkmanager-openvpn
    openvpn
    kubo

    ntfs3g
    arch-install-scripts
    android-file-transfer
    android-tools
    adbfs-rootless
    #   adb-sync #?

    cmatrix
    tmatrix
    haskellPackages.FractalArt
    arc-theme
    materia-theme

    # Cant download :(
    # unstable doesn't help
    #    unstable.libsForQt5.xp-pen-deco-01-v2-driver

    newestPython
    myPython

    perlProv
    perlPkgs.WWWYoutubeViewer
    perlPkgs.TermReadLineGnu
  ];
}
# TODO Categorize properly
# TODO flake builds of my programs
# TODO smapi - battery, proper linux for that

