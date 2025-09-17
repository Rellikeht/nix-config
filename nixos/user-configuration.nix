# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  # {{{
  pkgs,
  config,
  userName,
  ...
  # }}}
}: let
  # {{{
  vars = import ./local-vars.nix;
  langPkgs = import ./user-lang-pkgs.nix {inherit pkgs;};
  langs = langPkgs.langs;
  jdks = langPkgs.jdks;
  # }}}

  # {{{
  pkgImport = import ./pkgs.nix;
  userName = pkgImport.userName;
  userHome = "/home/${userName}";
  homeMode = "750";
  userGroup = "${userName}";
  userGid = 1000;
  userUid = 1000;
  # }}}

  nonLangs = with pkgs; ([
      # {{{
      # libreoffice-fresh
      # calibre
    ]
    ++ (with unstable; [
      (yt-dlp // {meta.priority = 2;})
    ]) # }}}
    ++ (with haskellPackages; [
      # {{{
      pandoc-cli
    ])); # }}}
in rec {
  users = {
    groups = {
      # {{{
      "syncthing" = {};
      ${userGroup} = {
        gid = userGid;
        members = [
          userName
        ];
      };
    }; # }}}

    users.default = {
      # {{{
      name = userName;
      home = userHome;
      uid = userUid;
      group = userGroup;
      initialPassword = vars.initPass;
      description = userName;
      isNormalUser = true;
      createHome = true;
      inherit homeMode;

      extraGroups = [
        # {{{
        "wheel"

        "users"
        "audio"
        "video"
        "disk"
        "render"
        "input"
        "uinput"
        "adm"
        "plocate"
        "pipewire"

        "adbusers"
        "networkmanager"
        "sshd"
        "syncthing"

        "sddm"
        "lp"
        "scanner"
        "cups"
        "docker"
        "wireshark"
        "dialout"
        "uucp"
        "tty"
      ]; # }}}

      packages = langs ++ nonLangs ++ jdks;
      shell = pkgs.zsh;
    }; # }}}
  };

  services = {
    # {{{
    cron.systemCronJobs = [
      # {{{
      "*/20 * * * * ${userName} ~/.dwm/dbackup.sh"
      "*/30 * * * * ${userName} ~/.dwm/dremove.sh"
    ]; # }}}

    syncthing = {
      # {{{
      enable = true;
      package = pkgs.unstable.syncthing;
      openDefaultPorts = true;
      systemService = false;

      user = "${userName}";
      configDir = "${userHome}/.config/syncthing";
      dataDir = "${userHome}/Shared";

      overrideDevices = false;
      overrideFolders = false;

      settings = {
        # {{{

        gui = {
          theme = "dark";
          user = userName;
          password = vars.syncthingPass;
        };

        options = {
          # {{{
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
        }; # }}}
      }; # }}}
    }; # }}}
  }; # }}}

  imports = [
    (
      import ./user-fsystem.nix
      {
        # {{{
        inherit userName userGroup;
        inherit userHome homeMode;
        inherit userGid userUid;
      } # }}}
    )
  ];
}
