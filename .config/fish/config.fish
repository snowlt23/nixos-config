alias v=nvim
alias vim=nvim
set -x EDITOR nvim
set -x PATH $PATH $HOME/nixos-config/scripts
set -x PATH $PATH $PATH:$HOME/private-scripts
set -x PATH $PATH $HOME/github/adhocc
alias ssh-desktop='mosh --no-ssh-pty --ssh="ssh -p 2225" snowlt23@192.168.1.3'
