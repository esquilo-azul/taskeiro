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

function taskeiro_run() {
  printf "$TASKEIRO_TASKS" | while read TASK; do _task_run "$TASK" ; done
}

function _task_run() {
  if _task_checked "$1" ; then return ; fi
  _task_check "$1"
  if ! _task_pass "$1" 1 ; then
    _call_task_function "$1" task_fix
    if ! _task_pass "$1" 0 ; then
      _fatal_error "Task \"$1\" failed to pass"
    fi
  fi
}

function _task_checked() {
  _validate_task_name "$1"
  echo "$TASKEIRO_CHECKED_TASKS" | grep "$1|" > /dev/null
}

function _task_check() {
  export TASKEIRO_CHECKED_TASKS=$TASKEIRO_CHECKED_TASKS"$1|"
}

function _task_pass() {
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
  _infov "$1" "$m"
}

function _call_task_function {
  local task=$1
  local script=$(taskeiro_task_path "$task")
  local function_name=$2
  unset -f $function_name
  source "$script"
  if _function_exists "$function_name"; then
    "$function_name"
  else
    _fatal_error "Function \"$function_name\" not found for task \"$task\""
  fi
}

function _function_exists() {
  type "$1" 2> /dev/null > /dev/null
}