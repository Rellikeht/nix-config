# vim: autoindent expandtab softtabstop=2 shiftwidth=2 tabstop=2
{
  pkgs,
  config,
  ...
}: let
in rec {
  services = {
    udev = {
      # {{{
      enable = true;
      packages = with pkgs; [
        utsushi
        android-udev-rules
        game-devices-udev-rules
      ];
    }; # }}}

    auto-cpufreq = {
      enable = false;
    };

    thermald = {
      # {{{
      # TODO
      enable = true;
    }; # }}}

    openssh = {
      # {{{
      enable = true;
      allowSFTP = true;
      openFirewall = true;

      settings = {
        # {{{
        PasswordAuthentication = true;
        X11Forwarding = true;
        PermitRootLogin = "no";
      }; # }}}

      extraConfig =
        # {{{
        ''
        '';
      # }}}
    }; # }}}

    fail2ban = {
      # {{{
      # TODO
      enable = false;

      daemonSettings = {
        # {{{
      }; # }}}

      extraPackages = with pkgs; [
        # {{{
      ]; # }}}

      # this probably should be private
      bantime = "15m";
      bantime-increment = {
        # {{{
      }; # }}}

      # This should be private
      ignoreIP = [];
    }; # }}}

    printing = {
      # {{{
      enable = true;
      drivers = with pkgs; [
        # {{{
        epson-escpr
        epson-escpr2
      ]; # }}}

      # ???
      # tempDir = "/tmp/cups";
    }; # }}}

    pipewire = {
      # {{{
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      systemWide = true;

      wireplumber = {
        # {{{
        enable = true;

        extraConfig = {
          "monitor.bluez.properties" = {
            # {{{
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.roles" = ["hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
          }; # }}}
        };
      }; # }}}

      alsa = {
        # {{{
        enable = true;
        support32Bit = true;
      }; # }}}

      extraConfig = {
        pipewire."92-low-latency" = {
          # {{{
          context = {
            properties = {
              default.clock.rate = 48000; # {{{
              default.clock.quantum = 32;
              default.clock.min-quantum = 32;
              default.clock.max-quantum = 32;
            }; # }}}

            modules = [
              # {{{
              {
                name = "libpipewire-module-protocol-pulse"; # {{{
                args = {
                  pulse.min.req = "32/48000";
                  pulse.default.req = "32/48000";
                  pulse.max.req = "32/48000";
                  pulse.min.quantum = "16/48000";
                  pulse.max.quantum = "32/48000";
                }; # }}}
              }
            ]; # }}}

            stream.properties = {
              # {{{
              node.latency = "32/48000";
              resample.quality = 1;
            }; # }}}
          };
        }; # }}}
      };
    }; # }}}

    tlp = {
      # {{{
      enable = true;
      settings = {
        # {{{
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MAX_PERF_ON_AC = 100;
        # CPU_MAX_PERF_ON_BAT = 60;

        # TODO :(
        STOP_CHARGE_THRESH_BAT0 = 80;
      }; # }}}
    }; # }}}

    locate = {
      # {{{
      enable = true;
      package = pkgs.plocate;
      localuser = null;
    }; # }}}

    fractalart = {
      enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput = {
      # {{{
      enable = true;
      touchpad = {
        tapping = false; # ???
        disableWhileTyping = true;
        middleEmulation = true;

        additionalOptions =
          # {{{
          ''
            Option "IgnorePalm" "true"
            Option "VertEdgeScroll" "on"
            Option "VertTwoFingerScroll" "on"
            Option "HorizEdgeScroll" "on"
            Option "HorizTwoFingerScroll" "on"
            Option "EmulateTwoFingerMinZ" "40"
            Option "EmulateTwoFingerMinW" "8"
            Option "CoastingSpeed" "0"
            Option "FingerLow" "40"
            Option "FingerHigh" "80"
            Option "MaxTapTime" "150"

            # Option "CircularScrolling" "on"
            # Option "CircScrollTrigger" "2"
          ''; # }}}
      };
    }; # }}}

    displayManager = {
      # {{{
      # defaultSession = "xfce";

      sddm = {
        # {{{
        enable = true;
        package = pkgs.unstable.sddm;
        wayland.enable = false;
        theme = "chili";
      }; # }}}

      # just in case,
      # doesn't do anything for now
      sessionPackages = with pkgs; [
        # {{{
        # builds.xinit-xsession
      ]; # }}}
    }; # }}}

    xserver = {
      # {{{
      enable = true;

      xkb = {
        # {{{
        layout = "pl";
        options = "caps:escape";
      }; # }}}

      desktopManager.xfce = {
        # {{{
        enable = true;
        enableScreensaver = false; # ?
      }; # }}}

      windowManager = {
        # {{{
        dwm = {
          # {{{
          enable = true;
          package = pkgs.builds.dwm;
        }; # }}}

        i3 = {
          # {{{
          enable = true;
          package = pkgs.i3; # ??

          extraPackages = with pkgs; [
            i3status
            dmenu
          ];

          # TODO fucking xinitrc
          # extraSessionCommands = "\$HOME/.xinitrc_common";
        }; # }}}

        awesome = {
          # {{{
          enable = true;
          # noArgb = true;
        }; # }}}
      }; # }}}

      displayManager = {
        # {{{
        # startx.enable = true;
        lightdm.enable = false;
        sessionCommands = "";

        session = [
          # {{{
          {
            # {{{ this makes xinit xsession work
            manage = "window";
            name = "xinitrc";
            start = "${pkgs.builds.xinit-xsession}/bin/xinitrcsession-helper";
          } # }}}
        ]; # }}}
      }; # }}}

      xautolock = {
        # {{{
        enable = true;
        enableNotifier = true;
        notifier = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds'";
        notify = 60;

        nowlocker = "${services.xserver.xautolock.locker}";
        extraOptions = [
          # {{{
          "-detectsleep"
        ]; # }}}

        locker = "${pkgs.xlockmore}/bin/xlock";
        time = 5;

        killer = "/run/current-system/systemd/bin/systemctl suspend";
        killtime = 10;
      }; # }}}
    }; # }}}

    cron = {
      # {{{
      enable = true;

      systemCronJobs = [
        # @reboot creating directories ??
        "*/30 * * * * root updatedb"
      ];
    }; # }}}

    blueman = {
      enable = true;
    };

    avahi = {
      # {{{
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
    }; # }}}

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
