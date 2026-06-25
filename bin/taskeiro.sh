#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
export TASKEIRO_BIN="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
export TASKEIRO_ROOT="$(dirname "$TASKEIRO_BIN")"

function taskeiro() {
  source "${TASKEIRO_ROOT}/init.sh"

  taskeiro_read_args "$@"
  taskeiro_start_banner
  taskeiro_validate
  taskeiro_before_run
  taskeiro_run
}
export -f taskeiro

if [[ ${BASH_SOURCE[0]} == $0 ]]; then
  taskeiro "${@}"
  exit $?
fi
