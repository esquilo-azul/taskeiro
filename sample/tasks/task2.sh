function task_condition() {
  return 1 # Always fails
}

function task_fix() {
  echo '' > /dev/null 2> /dev/null # Do nothing
}
