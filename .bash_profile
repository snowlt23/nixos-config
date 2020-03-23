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
alias kw=./kokowiki
kk() {
  ./kokowiki edit "$(xsel -bo)"
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}
