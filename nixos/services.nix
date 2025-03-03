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

      # 9.9 cve :)
      browsed.enable = false;

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
            Option "FingerLow" "35" # TODO
            Option "FingerHigh" "80" # TODO
            Option "MaxTapTime" "200" # TODO

            # Option "CircularScrolling" "on"
            # Option "CircScrollTrigger" "2"
          ''; # }}}
      };
    }; # }}}

    displayManager = {
      # {{{
      enable = true;
      defaultSession = "none+xinitrc";
      logToFile = true;
      logToJournal = true;

      sddm = {
        # {{{
        enable = true;
        # package = pkgs.kdePackages.sddm;
        package = pkgs.libsForQt5.sddm;
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
      exportConfiguration = true;

      videoDrivers = [
        #  {{{
        "modesetting"
        # "intel"
      ]; #  }}}

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
        lightdm = {
          enable = false;

          extraConfig = ''
            logind-check-graphical=true
          '';

          greeters = {
            gtk.enable = true;
            # mini.enable = true;
          };
        };

        sessionCommands = ''
          # automatic screen locking after some time
          xset s off
        '';

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

      xautolock =
        #  {{{
        let
          #  {{{
          b = builtins;
          mod = n: m: n - m * (n / m);
          nums = ["0" "1" "2" "3" "4" "5" "6" "7" "8" "9"];

          intToStr = n:
            if n == 0
            then "0"
            else its n "";

          its = n: s:
            if n == 0
            then s
            else let
              ns = b.elemAt nums (mod n 10) + s;
              nn = n / 10;
            in
              its nn ns;
          #  }}}

          secs = 15;
        in {
          # {{{
          enable = true;
          enableNotifier = true;
          notifier =
            "${pkgs.libnotify}/bin/notify-send"
            + "\"Locking in ${intToStr secs} seconds\"";
          notify = secs;

          nowlocker = "${services.xserver.xautolock.locker}";
          extraOptions = [
            # {{{
            "-detectsleep"
          ]; # }}}

          locker = "${pkgs.xlockmore}/bin/xlock";
          time = 4;

          killer = "/run/current-system/systemd/bin/systemctl suspend";
          killtime = 10;
        }; # }}} }}}
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

    # aria2 = { {{{
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
    # }; }}}

    # TODO C unclutter, xinit, xsession
    # TODO D hoogle ??
  };

  environment.etc = {
    #  {{{
    "X11/xorg.conf.d/20-thinkpad.conf".text = ''
      # NONE OF THIS SHIT WORK

      Section "InputClass"
      	Identifier	"Trackpoint Wheel Emulation"
      	MatchProduct	"TPPS/2 IBM TrackPoint|DualPoint Stick|Synaptics Inc. Composite TouchPad / TrackPoint|ThinkPad USB Keyboard with TrackPoint|USB Trackpoint pointing device|Composite TouchPad / TrackPoint"
      	MatchDevicePath	"/dev/input/event*"
        # Option		"EmulateWheel"		"true"
        # Option		"EmulateWheelButton"	"2"
        # Option		"Emulate3Buttons"	"false"
        # Option		"XAxisMapping"		"6 7"
        # Option		"YAxisMapping"		"4 5"
        Option "SendEventsMode" "1 0"
      EndSection

      Section "InputClass"
      	Identifier	"ThinkPad Extra Buttons"
      	MatchProduct	"ThinkPad Extra Buttons"
      	MatchDevicePath	"/dev/input/event*"
        Option "SendEventsMode" "1 0"
      EndSection
    '';
  }; #  }}}
}
