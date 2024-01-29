# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
# TODO do that with flakes maybe
let
  # Version of whole system
  stateVersion = "23.11";

  getChan = addr: import (fetchTarball addr);
  universalConf = {config = {allowUnfree = true;};};

  # Links to pkgs repos
  stableLink = "https://nixos.org/channels/nixos-${stateVersion}/nixexprs.tar.xz";
  unstableLink = "https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz";
  homeManagerLink = "https://github.com/nix-community/home-manager/archive/release-${stateVersion}.tar.gz";
  nurLink = "https://github.com/nix-community/NUR/archive/master.tar.gz";

  #oldVer = "23.05";
  #oldLink = "https://nixos.org/channels/nixos-${oldVer}/nixexprs.tar.xz";
  #old = getChan oldLink universalConf;

  # Is this pinning already?
  nixexprs = fetchTarball stableLink;
  pkgs = import nixexprs universalConf;
  unstableExprs = fetchTarball unstableLink;
  unstable = import unstableExprs universalConf;

  homeManagerExprs = fetchTarball homeManagerLink;
  homeManager = (import homeManagerExprs) {};
  nurExprs = fetchTarball nurLink;
  nur = (import nurExprs) {inherit pkgs;};
  # TODO nix index, but that is probably work for home manager

  # OMG THIS WORKS
  myRofi = final: prev: {
    rofi = prev.rofi.override {
      plugins = with prev; [
        rofi-calc
        rofi-emoji
        #rofi-file-browser
      ];
    };
  };

  overlays = [
    myRofi
  ];
in {
  #   And some simple exporting
  inherit stateVersion getChan universalConf;
  inherit stableLink unstableLink homeManagerLink nurLink;
  inherit pkgs nixexprs;
  inherit unstable unstableExprs;
  inherit homeManager homeManagerExprs;
  inherit nur nurExprs;
  inherit overlays;

  #  inherit oldPkgs;
}
