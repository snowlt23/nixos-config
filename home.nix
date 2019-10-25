{ pkgs, ... }:

{
  home.packages = [
  ];

  programs.git = {
    enable = true;
    userName = "snowlt23";
    userEmail = "shsnow23@gmail.com";
  };

  programs.vim = {
    enable = true;
    extraConfig = ''
    '';
    settings = {
      relativenumber = true;
      number = true;
    };
    plugins = with pkgs.vimPlugins; [
      vim-airline
    ];
  };

  home.file = {
    ".bashrc".source = ./.bashrc;
    ".Xresources".source = ./.Xresources;
    ".tmux.conf".source = ./.tmux.conf;
    ".config/i3/config".source = ./.config/i3/config;
    ".config/compton.conf".source = ./.config/compton.conf;
  };
}
