# nixos-config (snowlt23)

- WM: i3-gaps
- Browser: Brave
- Editor: Neovim
- Terminal: Urxvt
- Input Method: uim-skk

# Installation

**at NixOS install**
```
# rm /mnt/etc/nixos/configuration.nix
# git clone https://github.com/snowlt23/nixos-config
# cd nixos-config
# ./system-install.sh
# nixos-install
```

**at User install**
```sh
$ cd ~/
$ git clone https://github.com/snowlt23/nixos-config
$ cd nixos-config
$ sudo ./system-relink.sh
$ sudo nixos-rebuild switch
$ ./user-config.sh
```
