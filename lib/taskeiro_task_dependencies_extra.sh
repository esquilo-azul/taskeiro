function taskeiro_task_dependencies_extra() {
  hash_get 'EXTRA_DEPENDENCIES' "$1"
}
export -f taskeiro_task_dependencies_extra
