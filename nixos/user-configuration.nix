# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  config,
  lib,
  option,
  ...
}: let
  vars = import ./local-vars.nix;
  langPkgs = import ./user-lang-pkgs.nix {inherit pkgs;};

  nonLangs = with pkgs; [
    moc
    ungoogled-chromium
    zathura
    mupdf
    libreoffice-fresh
    pinta
    wxmaxima
    giac-with-xcas
    # qalculate-gtk

    tesseract
    almonds
  ];
in rec {
  imports = [
    ./user-fsystem.nix
    ./user-managers.nix
    ./user-gits.nix
  ];

  users.users.default = {
    name = vars.name;
    home = vars.home;
    initialPassword = vars.initPass;
    description = "standard user";
    isNormalUser = true;
    createHome = true;
    homeMode = "740";

    extraGroups = [
      "wheel"
      "users"
      "networkmanager"
      "audio"
      "video"
      "disk"
      "adbusers"
      "plocate"
      "sshd"
      "render"
      "syncthing"
      "input"
      "sddm"
      "adm"
      "lp"
    ];

    packages = with langPkgs;
      langs ++ nonLangs;

    shell = pkgs.zsh;
  };

  services = {
    cron.systemCronJobs = [
      "*/20 * * * * ${vars.name} ~/.dwm/dbackup.sh"
      "*/30 * * * * ${vars.home} ~/.dwm/dremove.sh"
    ];

    syncthing = {
      enable = true;
      user = "${vars.name}";
      configDir = "${vars.home}/.config/syncthing";
      dataDir = "${vars.home}/Shared";

      overrideDevices = true;
      overrideFolders = true;

      settings = {
        devices = vars.syncthingDevs;
        folders = vars.syncthingFolders;

        gui = {
          theme = "dark";
          user = vars.name;
          password = vars.syncthingPass;
        };

        defaults = {
          device = {
            id = vars.syncthingDefDevId;
          };
        };

        options = {
          minHomeDiskFree = {
            unit = "%";
            value = 2;
          };

          urAccepted = -1;
          startBrowser = false;
          relaysEnabled = false;
          globalAnnounceEnabled = true;
          localAnnounceEnabled = true;

          reconnectIntervalS = 20;
        };

        # TODO
        #          ignores = [
        #          { line = "*.swp"; }
        #          {  line = "*.~"; }
        #          {  line = "*.out"; }
        #          {  line = "*.bin"; }
        #          {  line = "*.so"; }
        #          ];
      };
    };
  };
}
# TODO global syncthing?

