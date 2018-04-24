function taskeiro_read_args() {
  while [[ $# > 0 ]] ; do
    key="$1"
    case $key in
      -h|--help)
      taskeiro_help
      exit 0
      ;;
      -p|--path)
      TASKEIRO_PATH=$(readlink -f "$2")
      shift
      ;;
    esac
    shift
  done
}

function taskeiro_help() {
  cat <<EOS
Usage:

  $TASKEIRO_EXECUTER -p|--path <TASKS_DIR>
  $TASKEIRO_EXECUTER -h|--help
EOS
  exit 0
}

function taskeiro_start_banner() {
  _infov 'Path' "$TASKEIRO_PATH"
}

function taskeiro_validate() {
  if [ ! -d "$TASKEIRO_PATH" ]; then
    _fatal_error "TASKEIRO_PATH \"$TASKEIRO_PATH\" is not a directory."
  fi
}
