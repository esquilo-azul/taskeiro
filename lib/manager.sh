source "$TASKEIRO_ROOT/lib/manager/dependencies.sh"

function taskeiro_before_run() {
  _taskeiro_path_callback '_before_run.sh'
}

function taskeiro_task_path() {
  local IFS=:
  for p in $TASKEIRO_PATH; do
    TARGET_PATH="$p/$1.sh"
    if [ -f "$TARGET_PATH" ]; then
      echo "$TARGET_PATH"
      exit 0
    fi
  done
  >&2 echo "Task file not found for name \"$1\""
  exit 1
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
    _fatal_error "Invalid task name: \"$1\""
  fi
}

function _task_valid_name() {
  echo $1 | grep '^[a-z0-9_]\+$' > /dev/null
}

function taskeiro_run() {
  printf "$TASKEIRO_TASKS" | while read TASK; do _task_run "$TASK" ; done
}

function _task_run() {
  _debug "START $1"
  if _task_checked "$1" ; then
    _debug "END $1 (ALREADY CHECKED: $TASKEIRO_CHECKED_TASKS)"
    return
  fi
  _task_check "$1"
  for dep in $(taskeiro_task_dependencies "$1"); do
    _debug "DEPENDENCY $1 -> $dep"
    _task_run "$dep"
  done
  _taskeiro_path_callback '_before_task.sh'
  if ! _task_pass "$1" 1 ; then
    _call_task_function "$1" task_fix
    if ! _task_pass "$1" 0 ; then
      _fatal_error "Task \"$1\" failed to pass"
    fi
  fi
  _debug "END $1"
}

function _task_checked() {
  _validate_task_name "$1"
  echo "$TASKEIRO_CHECKED_TASKS" | grep "|$1|" > /dev/null
}

function _task_check() {
  _debug "CHECK $1"
  export TASKEIRO_CHECKED_TASKS=$TASKEIRO_CHECKED_TASKS"$1|"
}

function _task_pass() {
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
  if _call_task_function "$1" task_condition ; then
    RESULT=0
  else
    RESULT=1
  fi
  _task_message_condition "$1" "$RESULT" "$2"
  return $RESULT
}

function _task_message_condition {
  local result=$2
  local after=$3
  local m=''
  if [ "$2" == '0' ]; then
    m=$m"${FG_LGREEN}ok${NC}"
  else
    m=$m"${FG_LRED}not ok${NC}"
  fi
  if [ "$3" == '0' ]; then
    m=$m' (AFTER FIX)'
  fi
  m=$m" $FG_LYELLOW[$(taskeiro_task_dependencies "$1")]$NC"
  _infov "$1" "$m"
}

function _call_task_function {
  local task=$1
  local script=$(taskeiro_task_path "$task")
  local function_name=$2
  local required='0'
  if [ $# -ge 3 ]; then
    required=$3
  fi
  unset -f $function_name
  source "$script"
  if _function_exists "$function_name"; then
    "$function_name"
  elif [ "$required" == '0' ]; then
    _fatal_error "Function \"$function_name\" not found for task \"$task\""
  fi
}

function _function_exists() {
  type "$1" 2> /dev/null > /dev/null
}
