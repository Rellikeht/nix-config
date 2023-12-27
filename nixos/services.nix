# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  config,
  option,
  ...
}: let
  noPassCmd = name: {
    groups = ["wheel"];
    noPass = true;
    cmd = name;
  };
in rec {
  security = {
    doas = {
      enable = true;
      extraRules =
        [
          {
            groups = ["wheel"];
            keepEnv = true;
            persist = true;
          }
        ]
        ++ map noPassCmd [
          "brightnessctl"
        ];
    };

    sudo = {
      enable = true;
      extraRules = [
        {
          groups = ["wheel"];
          commands = ["ALL"];
        }
      ];
    };
  };

  networking = {
    # hostName = "nixos";
    hostName = config.system.name;
    networkmanager.enable = true;

    firewall = {
      #      enable = false;
      allowPing = false;

      # TODO
      # Open ports in the firewall.
      #      allowedTCPPorts = [ ... ];
      #      allowedUDPPorts = [ ... ];
    };

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraConfig = "
        load-module module-switch-on-connect
      ";
    };

    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    openssh.enable = true;
    printing.enable = true;
    thermald.enable = true;

    # TODO pipewire
    #    pipewire = {
    #      enable = true;
    #
    #      alsa = {
    #        enable = true;
    #        support32Bit = true;
    #      };
    #
    #      pulse.enable = true;
    #    };

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

    xserver = {
      enable = true;
      layout = "pl";
      xkbOptions = "caps:escape";

      # Enable touchpad support (enabled default in most desktopManager).
      libinput = {
        enable = true;
        touchpad = {
          tapping = true; # ???
          disableWhileTyping = true;
        };
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
          #          extraSessionCommands = "\$HOME/.xinitrc_common";
        };

        awesome = {
          enable = true;
          #          noArgb = true;
        };
      };

      displayManager = {
        lightdm.enable = false;
        defaultSession = "xfce";
        sessionCommands = "";

        sddm = {
          enable = true;
          theme = "chili";
          # theme = pkgs.sddm-chili-theme;
        };
      };

      xautolock = {
        # ???
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

    # TODO aria2 daemon
  };
}
