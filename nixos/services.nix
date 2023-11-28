# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

{ config, option, ... }:
let
pkgImport = import ./pkgs.nix;

in
with pkgImport;
rec {

  networking = {
    hostName = "nixos";
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
    pulseaudio.enable = true;
    bluetooth.enable = true;
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
#      package = pkgs.plocate;
      locate = pkgs.plocate;
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
          theme = "maladives";
        };
      };

      xautolock = { # ???
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

      systemCronJobs = [ # @reboot creating directories ??
        "*/30 * * * * root updatedb"
      ];

    };

  };

  security = {
    doas = {
      enable = true;
      extraRules = [

      {
        groups = ["wheel"];
        keepEnv = true;
        runAs = "root";
        persist = true;
      }

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

}

