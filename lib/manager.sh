function taskeiro_task_path() {
  echo "$TASKEIRO_PATH/$1.sh"
}

function _validate_task_name() {
  if ! _task_valid_name "$1"; then
    _fatal_error "Invalid task name: \"$1\""
  fi
}

function _task_valid_name() {
  echo $1 | grep '^[a-z0-9_]\+$' > /dev/null
}
