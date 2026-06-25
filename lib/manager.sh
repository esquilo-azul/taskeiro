function taskeiro_before_run() {
  _taskeiro_path_callback '_before_run.sh'
}

function taskeiro_task_path() {
  local IFS=:
  for p in $TASKEIRO_PATH; do
    TARGET_PATH="$p/$1.sh"
    if [ -f "$TARGET_PATH" ]; then
      echo "$TARGET_PATH"
      return 0
    fi
  done
  >&2 echo "Task file not found for name \"$1\""
  return 1
}

function _taskeiro_path_callback() {
  SUBPATH="$1"
  _debug "START _taskeiro_path_callback()" "$@"
  local IFS=:
  for p in $TASKEIRO_PATH; do
    BEFORE_RUN_PATH="${p}/${SUBPATH}"
    if [ -f "$BEFORE_RUN_PATH" ]; then
      _debug "Callback ${BEFORE_RUN_PATH}: found"
      source "$BEFORE_RUN_PATH"
    else
      _debug "Callback ${BEFORE_RUN_PATH}: not found"
    fi
  done
  _debug "END _taskeiro_path_callback()" "$@"
}

function _validate_task_name() {
  if ! _task_valid_name "$1"; then
    fatal_error "Invalid task name: \"$1\""
  fi
}

function taskeiro_run() {
  printf "$TASKEIRO_TASKS" | while read TASK; do _task_run "$TASK" ; done
}

function _taskeiro_path_callback() {
  SUBPATH="$1"
  local IFS=:
  for p in $TASKEIRO_PATH; do
    BEFORE_RUN_PATH="${p}/${SUBPATH}"
    if [ -f "$BEFORE_RUN_PATH" ]; then
      source "$BEFORE_RUN_PATH"
    fi
  done
}
