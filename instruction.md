# nix installation

- 1st after boot
  `sudo nix-shell -p git nixFlakes`

- clone tampelete
  `git clone https://github.com/IogaMaster/templates my-nixos
cd my-nixos`

<!-- DX: ### all the files are inside ./files/ folder its just for keeping files and not related to setup. -->

 <!-- Y:  LOCAL FILES  -->

./files/flake.nix
./files/configuration.nix
./files/home.nix

## copy this 🠝 files to /etc/nixos/

`sudo nixos-rebuild switch --flake .`

🠝 This gives you:
✅ Bootloader (systemd-boot)
✅ Swap support (from installer partitioning)
✅ CLI-first environment with all your dev tools
✅ Home Manager managing dotfiles
