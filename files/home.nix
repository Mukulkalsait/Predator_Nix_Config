{ config, pkgs, ... }:

{
  home.username = "mukul";
  home.homeDirectory = "/home/mukul";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    neovim
    starship
    fzf
    lazygit
    yazi
    nodejs
    cargo
    rustc
    python3
  ];

  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.git.enable = true;
  programs.fzf.enable = true;
}
