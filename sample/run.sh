#!/bin/bash

export MYROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export TASKEIRO=$(dirname "$MYROOT")/taskeiro

function sample_run() {
  if [ -n "$SAMPLE_TEMP_DIR" ]; then
    rm -rf "$SAMPLE_TEMP_DIR"
  fi
  export SAMPLE_TEMP_DIR=$(mktemp -d)
  >&2 echo '-----------------------'
  >&2 echo "SAMPLE RUN: $TASKEIRO $@"
  >&2 echo '-----------------------'
  $TASKEIRO "$@"
}

sample_run --help
sample_run
sample_run --path "$MYROOT/tasks"
sample_run --path "$MYROOT/tasks" task1 task1
sample_run --path "$MYROOT/tasks" task1 task2
sample_run --path "$MYROOT/tasks" not_exist
