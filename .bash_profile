alias vim=nvim
alias r=ranger
export EDITOR=nvim
PATH=$PATH:$HOME/nixos-config/scripts
PATH=$PATH:$HOME/private-scripts
PATH=$PATH:$HOME/github/adhocc
alias ns='sudo nixos-rebuild switch'
alias hs='home-manager switch'
alias ssh-desktop='mosh snowlt23@192.168.1.4'
export PROMPT_COMMAND="pwd > /tmp/whereami"

function _update_ps1() {
    PS1="$(powerline-go -modules user,cwd,gitlite)"
}

PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
