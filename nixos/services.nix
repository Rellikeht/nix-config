# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  config,
  ...
}: let
in rec {
  services = {
    udev = {
      enable = true;
      packages = with pkgs; [
        utsushi
      ];
    };

    openssh.enable = true;
    printing = {
      enable = true;
      drivers = with pkgs; [
        epson-escpr
        epson-escpr2
      ];

      # ???
      # tempDir = "/tmp/cups";
    };
    thermald.enable = true;

    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      systemWide = true;

      wireplumber = {
        enable = true;
      };

      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "conservative";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    locate = {
      enable = true;
      package = pkgs.plocate;
      localuser = null;
    };

    fractalart = {
      enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput = {
      enable = true;
      touchpad = {
        tapping = true; # ???
        disableWhileTyping = true;
      };
    };

    displayManager = {
      defaultSession = "xfce";
      sddm = {
        enable = true;
        theme = "chili";
        # theme = pkgs.sddm-chili-theme;
      };
    };

    xserver = {
      enable = true;

      xkb = {
        layout = "pl";
        options = "caps:escape";
      };

      desktopManager.xfce = {
        enable = true;
        enableScreensaver = false; # ?
      };

      windowManager = {
        i3 = {
          enable = true;
          package = pkgs.i3; # ??

          extraPackages = with pkgs; [
            i3status
            dmenu
          ];

          # TODO fucking xinitrc
          # extraSessionCommands = "\$HOME/.xinitrc_common";
        };

        awesome = {
          enable = true;
          #          noArgb = true;
        };
      };

      displayManager = {
        lightdm.enable = false;
        sessionCommands = "";
      };

      xautolock = {
        enable = true;
        nowlocker = "${services.xserver.xautolock.locker}";
        extraOptions = [
          "-detectsleep"
        ];

        locker = "${pkgs.xlockmore}/bin/xlock";
        time = 5;

        killer = "/run/current-system/systemd/bin/systemctl suspend";
        killtime = 10;
      };
    };

    cron = {
      enable = true;

      systemCronJobs = [
        # @reboot creating directories ??
        "*/30 * * * * root updatedb"
      ];
    };

    blueman = {
      enable = true;
    };

    avahi = {
      enable = true;
      cacheEntriesMax = 32767;
      domainName = "nygus";

      nssmdns4 = true;
      openFirewall = true;

      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };

    ipp-usb.enable = true;

    # aria2 = {
    #   enable = true;
    #   openPorts = false;
    #   # rpcSecretFile = "/run/secrets/aria2-rpc-secret";
    #   # rpcSecretFile = "/dev/null";

    #   extraArguments = ''
    #     --continue=true
    #     --max-concurrent-downloads=200
    #     --optimize-concurrent-downloads=true
    #     --bt-detach-seed-only=true
    #     --bt-max-peers=100
    #     --seed-ratio=0.0
    #     --check-integrity=true
    #     --file-allocation=prealloc
    #   '';
    # };

    # TODO unclutter, xinit, xsession
    # TODO hoogle ??
  };
}
