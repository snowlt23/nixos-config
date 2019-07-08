if [[ ! -n $TMUX ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session && exit
  fi
  create_new_session="Create New Session"
  ID=$(printf "${create_new_session}\n${ID}")
  ID=$(echo "$ID" | peco | cut -d: -f1)
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session && exit
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi
