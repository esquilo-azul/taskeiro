hash_init 'EXTRA_DEPENDENCIES'

function taskeiro_task_dependencies() {
  local EXTRA="$(_extra_dependencies_get "$1")"
  local SELF="$(_call_task_function "$1" task_dependencies 1)"
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

function taskeiro_add_dependency() {
  local TARGET="$1"
  shift
  for DEPENDENCY in "$@"; do
    _extra_dependencies_add "$TARGET" "$DEPENDENCY"
  done
}
