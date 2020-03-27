alias ns="sudo nixos-rebuild switch"
alias l=ls
alias em="emacs -nw"
alias vim=nvim
EDITOR="emacs -nw"
PATH=$PATH:~/nixos-config
PATH=$PATH:~/nixos-config/scripts
PATH=$PATH:~/private-scripts
PS1="\e[32m\u\e[0m:\e[34m\w\e[0m\n$ "
export PROMPT_COMMAND="pwd > /tmp/whereami"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
