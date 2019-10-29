alias vim=nvim
export EDITOR=nvim
PATH=$PATH:$HOME/nixos-config/scripts
PATH=$PATH:$HOME/private-scripts
PATH=$PATH:$HOME/github/adhocc
alias ssh-desktop='mosh --no-ssh-pty --ssh="ssh -p 2225" snowlt23@192.168.1.3'
export PROMPT_COMMAND="pwd > /tmp/whereami"
