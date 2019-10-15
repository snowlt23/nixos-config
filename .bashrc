alias v=nvim
alias vim=nvim
export EDITOR=nvim
PATH=$PATH:$HOME/nixos-config/scripts
PATH=$PATH:$HOME/private-scripts
PATH=$PATH:$HOME/github/adhocc
alias ssh-desktop='mosh --no-ssh-pty --ssh="ssh -p 2225" snowlt23@192.168.1.3'
export PROMPT_COMMAND="pwd > /tmp/whereami"

# SESSION_NAME=main
# 
# if [[ -z "$TMUX" && -z "$STY" ]] && type tmux >/dev/null 2>&1; then
#   option=""
#   if tmux has-session -t ${SESSION_NAME}; then
#     option="attach -t ${SESSION_NAME}"
#   else
#     option="new -s ${SESSION_NAME}"
#   fi  
#   tmux $option && exit
# fi
