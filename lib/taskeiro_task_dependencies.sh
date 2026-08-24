function taskeiro_task_dependencies() {
  local EXTRA="$(taskeiro_task_dependencies_extra "$1")"
  local SELF="$(taskeiro_task_call_function "$1" task_dependencies 1)"
  if [[ -n "$EXTRA" ]] && [[ -n "$SELF" ]]; then
    echo "$EXTRA $SELF"
  elif [[ -n "$EXTRA" ]]; then
    echo "$EXTRA"
  elif [[ -n "$SELF" ]]; then
    echo "$SELF"
  else
    echo ''
  fi
}
export -f taskeiro_task_dependencies
