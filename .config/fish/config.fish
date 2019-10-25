alias vim=nvim
set -x EDITOR nvim
set -x PATH $PATH $HOME/nixos-config/scripts
set -x PATH $PATH $PATH:$HOME/private-scripts
alias ssh-desktop='mosh --no-ssh-pty --ssh="ssh -p 2225" snowlt23@192.168.1.3'
set -x PROMPT_COMMAND="pwd > /tmp/whereami"
