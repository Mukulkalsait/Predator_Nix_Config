{ config, pkgs, hyprland, ... }:

{
  home.username = "mukul";
  home.homeDirectory = "/home/mukul";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  # Essential development packages
  home.packages = with pkgs; [
    # Terminal and shell tools
    kitty
    alacritty
    fish
    starship
    fzf
    eza
    bat
    ripgrep
    fd
    zoxide
    lazygit
    yazi
    
    # Development tools
    neovim
    nodejs
    python3
    cargo
    rustc
    go
    
    # Wayland/Hyprland specific tools
    waybar
    wofi
    rofi-wayland
    dunst
    swww # wallpaper daemon
    grim # screenshot
    slurp # area selection for screenshots
    wf-recorder # screen recording
    wl-clipboard
    cliphist
    
    # System utilities
    brightnessctl
    playerctl
    pamixer
    pavucontrol
    
    # For building QuickShell
    qt6.full
    qt6.qtdeclarative
    qt6.qtwayland
    cmake
    ninja
    pkg-config
    
    # Audio/multimedia
    pipewire
    wireplumber
    
    # File manager
    nautilus
    
    # Image viewer
    imv
    
    # For celestial dots dependencies
    python3Packages.requests
    python3Packages.pillow
    jq
    socat
    
    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "Hack" ]; })
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
    
    shellAliases = {
      ll = "eza -la";
      ls = "eza";
      cat = "bat";
      grep = "rg";
      find = "fd";
      cd = "z";
    };
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "z" ];
      theme = "robbyrussell";
    };
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Kitty terminal
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      background_opacity = "0.9";
      window_padding_width = 8;
      confirm_os_window_close = 0;
    };
    theme = "Dracula";
  };

  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.system}.hyprland;
    
    settings = {
      # Monitor configuration
      monitor = ",preferred,auto,1";
      
      # Environment variables
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "QT_QPA_PLATFORM,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "MOZ_ENABLE_WAYLAND,1"
        "GDK_BACKEND,wayland,x11"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "NVIDIA_DISABLE_FLIPPING,1"
      ];
      
      # Input configuration
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };
      
      # General settings
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };
      
      # Decoration
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
      
      # Animations
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
      
      # Key bindings (basic set)
      bind = [
        # Launch applications
        "SUPER, RETURN, exec, kitty"
        "SUPER, E, exec, yazi"
        "SUPER, R, exec, wofi --show drun"
        "SUPER, B, exec, firefox"
        
        # Window management
        "SUPER, Q, killactive"
        "SUPER, M, exit"
        "SUPER, V, togglefloating"
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
        
        # Move window to workspace
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        
        # Screenshots
        "SUPER, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        "SUPER SHIFT, S, exec, grim - | wl-copy"
      ];
      
      # Mouse bindings
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      
      # Startup applications
      exec-once = [
        "swww init"
        "dunst"
        "wl-paste --watch cliphist store"
      ];
    };
  };

  # Create script for celestial dots installation
  home.file.".local/bin/install-celestial-dots" = {
    text = ''
      #!/usr/bin/env bash
      set -e
      
      echo "Installing Celestial Dots..."
      
      # Clone celestial dots
      if [ ! -d "$HOME/.config/celestial-dots" ]; then
          git clone https://github.com/caelestia-dots/shell.git "$HOME/.config/celestial-dots"
      fi
      
      # Clone and build QuickShell
      if [ ! -d "$HOME/quickshell" ]; then
          git clone https://github.com/quickshell-mirror/quickshell.git "$HOME/quickshell"
          cd "$HOME/quickshell"
          cmake -B build -DCMAKE_BUILD_TYPE=Release
          cmake --build build
          sudo cmake --install build
      fi
      
      echo "Celestial dots setup complete!"
      echo "You can now run 'caelestia shell -d' or 'qs -c caelestia'"
    '';
    executable = true;
  };
}