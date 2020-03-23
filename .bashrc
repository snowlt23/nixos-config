alias vim=nvim
EDITOR=nvim
WINHOME=/mnt/c/Users/shsno
PATH=$PATH:~/private
PATH=$PATH:~/private/scripts
PATH=$PATH:$WINHOME/scoop/shims
PATH=$PATH:/mnt/c/Installs/bin
PATH=$PATH:~/github/mikoforth
PS1="\e[32m\u\e[0m:\e[34m\w\e[0m\n$ "
export PROMPT_COMMAND="pwd > /tmp/whereami"

alias kd="cd ~/Nextcloud/kokowiki"
kw() {
  CURR=$(pwd)
  kd
  ./kokowiki "$@"
  cd "$CURR"
}
kk() {
  kw edit "$(xsel -bo)"
}
ki() {
  FILE=$(dirname "$1")/$(basename "$1")
  kw image "$FILE"
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
