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

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fvim() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf -m --preview 'head -100 {}') &&
  vim $selected_files
}

fga() {
  modified_files=$(git status --short | awk '{print $2}') &&
  selected_files=$(echo "$modified_files" | fzf -m --preview 'git diff {}') &&
  git add $selected_files &&
  fga
}
