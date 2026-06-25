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

function taskeiro_run() {
  printf "$TASKEIRO_TASKS" | while read TASK; do _task_run "$TASK" ; done
}
