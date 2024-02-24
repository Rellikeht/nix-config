rec {
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.11;
    nixpkgs-unstable.url = github:NixOS/nixpkgs;
    # nixpkgs-old.url = github:NixOS/nixpkgs/nixos-23.05;

    homeManager = {
      url = github:nix-community/home-manager/release-23.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = github:nix-community/NUR;
    flakeUtils.url = github:numtide/flake-utils;
    nix-builds.url = github:Rellikeht/nix-builds;

    locals = {
      url = path:/etc/nixos-local;
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    # nixpkgs-old,
    homeManager,
    nur,
    flakeUtils,
    nix-builds,
    locals,
    ...
  } @ attrs: let
    system = "x86_64-linux";
    sysVer = nixpkgs.stateVersion;

    config = {
      config.allowUnfree = true;
      system = system;
    };

    pkgs = import nixpkgs config;
    unstable = import nixpkgs-unstable config;
    # old = import nixpkgs-old config;
  in {
    nixosConfigurations = {
      declarativeMonster = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit attrs sysVer;
        };
        modules = [
          ./configuration.nix
          locals
          homeManager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
    };
  };
}
