# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  config,
  ...
} @ inputs: let
  vars = import ./local-vars.nix;
  langPkgs = import ./user-lang-pkgs.nix {inherit pkgs;};
  langs = langPkgs.langs;
  jdks = langPkgs.jdks;
  # TODO jdks

  pkgImport = import ./pkgs.nix;
  userName = pkgImport.userName;
  userHome = "/home/${userName}";
  homeMode = "750";
  userGroup = "michal";
  userGid = 1000;
  userUid = 1000;

  nonLangs = with pkgs; [
    moc
    libreoffice-fresh
    wxmaxima
    giac-with-xcas

    tesseract
    almonds

    gimp
    inkscape
  ];
in rec {
  users = {
    groups = {
      ${userGroup} = {
        gid = userGid;
        members = [
          userName
        ];
      };
    };

    users.default = {
      name = userName;
      home = userHome;
      uid = userUid;
      group = userGroup;
      initialPassword = vars.initPass;
      description = "standard user";
      isNormalUser = true;
      createHome = true;
      inherit homeMode;

      extraGroups = [
        "wheel"

        "users"
        "audio"
        "video"
        "disk"
        "render"
        "input"
        "adm"
        "plocate"

        "adbusers"
        "networkmanager"
        "sshd"
        "syncthing"

        "sddm"
        "lp"
        "scanner"
        "cups"
      ];

      packages = langs ++ nonLangs;

      shell = pkgs.zsh;
    };
  };

  services = {
    cron.systemCronJobs = [
      "*/20 * * * * ${userName} ~/.dwm/dbackup.sh"
      "*/30 * * * * ${userName} ~/.dwm/dremove.sh"
    ];

    # TODO devices to local hardware config
    syncthing = {
      enable = true;
      user = "${userName}";
      configDir = "${userHome}/.config/syncthing";
      dataDir = "${userHome}/Shared";

      overrideDevices = true;
      overrideFolders = true;

      settings = {
        devices = vars.syncthingDevs;
        folders = vars.syncthingFolders;

        gui = {
          theme = "dark";
          user = userName;
          password = vars.syncthingPass;
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

  imports = [
    # probably for home manager
    (
      import ./user-fsystem.nix
      {
        inherit userName userGroup;
        inherit userHome homeMode;
        inherit userGid userUid;
      }
    )
  ];
}
