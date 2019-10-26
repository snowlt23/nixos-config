{ pkgs, ... }:

{
  home.packages = [
  ];

  programs.git = {
    enable = true;
    userName = "snowlt23";
    userEmail = "shsnow23@gmail.com";
  };

  home.file = {
    ".bashrc".source = ./.bashrc;
    ".config/polybar/config".source = ./.config/polybar/config;
    ".config/polybar/launch.sh".source = ./.config/polybar/launch.sh;
    ".config/polybar/memory.sh".source = ./.config/polybar/memory.sh;
    ".config/polybar/volume.sh".source = ./.config/polybar/volume.sh;
    ".Xresources".source = ./.Xresources;
    ".tmux.conf".source = ./.tmux.conf;
    ".config/nvim/init.vim".source = ./.config/nvim/init.vim;
    ".config/i3/config".source = ./.config/i3/config;
    ".config/compton.conf".source = ./.config/compton.conf;
  };
}
