function _taskeiro_path_callback() {
  SUBPATH="$1"
  _debug "START _taskeiro_path_callback()" "$@"

  while read -r BEFORE_RUN_PATH; do
    _debug "Callback ${BEFORE_RUN_PATH}: found"
    source "$BEFORE_RUN_PATH"
  done < <(pathvar_find_files 'TASKEIRO_PATH' "$SUBPATH" )

  _debug "END _taskeiro_path_callback()" "$@"
}
export -f _taskeiro_path_callback
