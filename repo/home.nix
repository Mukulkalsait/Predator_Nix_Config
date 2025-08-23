{ config, pkgs, ... }:

{
  home.username = "mukul";
  home.homeDirectory = "/home/mukul";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  # Desktop packages
  home.packages = with pkgs; [
    # Terminal and shell
    neovim
    starship
    fzf
    lazygit
    yazi
    
    # Development
    nodejs
    cargo
    rustc
    python3
    go
    
    # Desktop apps
    firefox
    discord
    spotify
    obsidian
    
    # System utilities
    rofi
    dunst
    picom
    nitrogen
    flameshot
    brightnessctl
    playerctl
    pamixer
    
    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
    
    # For the shell setup (similar to celestial dots)
    kitty
    fish
    exa
    bat
    ripgrep
    fd
    zoxide
    
    # Wayland specific (for Hyprland)
    waybar
    wofi
    swww
    grim
    slurp
    wl-clipboard
    
    # For quickshell dependencies
    qt6.full
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtdeclarative
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "mukul_dk_nix";
    userEmail = "your-email@example.com"; # Replace with your email
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "kubectl" ];
      theme = "robbyrussell";
    };
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # FZF
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Kitty terminal
  programs.kitty = {
    enable = true;
    theme = "Dracula";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      background_opacity = "0.9";
      window_padding_width = 8;
    };
  };

  # Hyprland configuration (if using Wayland)
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,auto";
      
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };
      
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };
      
      # Keybindings
      bind = [
        "SUPER, Q, exec, kitty"
        "SUPER, C, killactive"
        "SUPER, M, exit"
        "SUPER, E, exec, yazi"
        "SUPER, V, togglefloating"
        "SUPER, R, exec, wofi --show drun"
        "SUPER, P, pseudo"
        "SUPER, J, togglesplit"
        
        # Move focus
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
        
        # Switch workspaces
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        
        # Move active window to workspace
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        
        # Screenshot
        "SUPER, S, exec, grim -g \"$(slurp)\" - | wl-copy"
      ];
      
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      
      # Window rules
      windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];
      
      # Startup
      exec-once = [
        "waybar"
        "swww init"
        "dunst"
      ];
    };
  };

  # Waybar configuration
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        
        modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "idle_inhibitor" "pulseaudio" "network" "cpu" "memory" "temperature" "battery" "clock" "tray" ];
        
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}: {icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            urgent = "";
            focused = "";
            default = "";
          };
        };
        
        "hyprland/window" = {
          format = "{}";
          separate-outputs = true;
        };
        
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        
        memory = {
          format = "{}% ";
        };
        
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" "" "" ];
        };
        
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        
        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
      };
    };
    
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
      }
      
      window#waybar {
        background-color: rgba(43, 48, 59, 0.5);
        border-bottom: 3px solid rgba(100, 114, 125, 0.5);
        color: #ffffff;
        transition-property: background-color;
        transition-duration: .5s;
      }
      
      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #ffffff;
        border-bottom: 3px solid transparent;
      }
      
      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
        box-shadow: inset 0 -3px #ffffff;
      }
      
      #workspaces button.focused {
        background-color: #64727D;
        border-bottom: 3px solid #ffffff;
      }
      
      #clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #tray {
        padding: 0 10px;
        margin: 0 4px;
        color: #ffffff;
      }
    '';
  };

  # Shell aliases
  home.shellAliases = {
    ll = "exa -la";
    ls = "exa";
    cat = "bat";
    grep = "rg";
    find = "fd";
    cd = "z";
  };
}