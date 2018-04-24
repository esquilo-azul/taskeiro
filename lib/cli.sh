function taskeiro_read_args() {
  while [[ $# > 0 ]] ; do
    key="$1"
    case $key in
      -h|--help)
      taskeiro_help
      exit 0
      ;;
    esac
    shift
  done
}

function taskeiro_help() {
  cat <<EOS
Usage:

  $TASKEIRO_EXECUTER -h|--help
EOS
  exit 0
}
