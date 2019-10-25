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
    ".Xresources".source = ./.Xresources;
    ".tmux.conf".source = ./.tmux.conf;
    ".config/nvim/init.vim".source = ./.config/nvim/init.vim;
    ".config/i3/config".source = ./.config/i3/config;
    ".config/compton.conf".source = ./.config/compton.conf;
  };
}
