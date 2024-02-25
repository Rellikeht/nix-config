# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
# TODO do that with flakes maybe
let
  # Version of whole system ?
  stateVersion = "23.11";
  sysName = "declarativeMonster";
  userName = "michal";
  # userHome = "/home/${userName}";

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

  nixexprs = fetchTarball stableLink;
  pkgs = import nixexprs universalConf;
  unstableExprs = fetchTarball unstableLink;
  pkgs-unstable = import unstableExprs universalConf;

  homeManagerExprs = fetchTarball homeManagerLink;
  homeManager = (import homeManagerExprs) {};
  nurExprs = fetchTarball nurLink;
  nur = (import nurExprs) {inherit pkgs;};
  # TODO nix index, but that is probably work for home manager
in {
  #   And some simple exporting
  inherit stateVersion sysName userName;
  # inherit userHome;

  inherit pkgs nixexprs;
  inherit pkgs-unstable unstableExprs;
  inherit homeManager homeManagerExprs;
  inherit nur nurExprs;

  #  inherit oldPkgs;
}
