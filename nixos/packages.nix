# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

{ pkgs, config, ... }:
let

in

{

  environment.systemPackages = with pkgs; [
    home-manager.home-manager

    vim
    neovim
    neovim-qt
    kakoune
    vis

    vifm
    ranger
    fdupes

    unstable.groff
    glow
    mdp
    mdr
    lowdown

    screen
    physlock
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

    direnv
    nix-direnv
    nix-zsh-completions
    nix-bash-completions
    zsh-nix-shell
    nix-du
    unstable.nixd
    nixfmt
    nix-top
    nix-tree
    nixos-shell

#    python3Full
    sbcl
    clisp
    guile
    lua
    luajit
    maxima
    R
    gforth
    tcl
    tclreadline
    tk

    unstable.go
    unstable.zig
    unstable.nim

    gcc
    jdk

    unstable.ghc
    unstable.rustc
    unstable.ocaml
    unstable.gopls
    unstable.zls
    unstable.zig-shell-completions
    unstable.nimlsp
    unstable.rustfmt
    unstable.rust-analyzer
    unstable.opam
    unstable.ocamlPackages.utop
    unstable.ocamlPackages.ocaml-lsp
    unstable.haskell-language-server
    unstable.nil

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

    unstable.e2fsprogs
    util-linux
    os-prober
    help2man

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
    dhcpcd
    wpa_supplicant
    speedtest-cli
    inetutils

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
    ffmpeg
    yt-dlp
    ytfzf
    mediainfo
    file
    iconv

    old.spotdl

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

    git
    aria
    wget
    curl
    rsync
    phodav
    cadaver
    megatools

    sshfs
    davfs2

    papirus-icon-theme
    fontconfig
    freetype
    ghostscript

    dmenu # Remove when installed properly
    unclutter
    dzen2
    shotgun
    scrot
    rofi
    rofi-pass
    rofi-calc
    rofi-emoji

    mesa-demos
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

# WARNING VERSIONS AHEAD
# Cant download :(
# unstable doesn't help
#    unstable.libsForQt5.xp-pen-deco-01-v2-driver

    unstable.python313Full

    python311Full
    python311Packages.bpython
    python311Packages.pip
    python311Packages.python-lsp-server
    python311Packages.pynvim

    unstable.perl538Packages.WWWYoutubeViewer
    unstable.perl538Packages.TermReadLineGnu

  ];
}

# TODO Categorize properly
# TODO smapi - battery, proper linux for that
