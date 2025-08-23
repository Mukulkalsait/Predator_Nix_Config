{
  description = "Mukul's NixOS with Home Manager and Desktop Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # For Hyprland (modern wayland compositor)
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
        inherit system;
        config.allowUnfree = true; # For NVIDIA drivers
      };
    in {
      nixosConfigurations.mukul = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          hyprland.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mukul = import ./home.nix;
          }
        ];
      };
    };
}