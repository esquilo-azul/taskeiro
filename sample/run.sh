#!/bin/bash

export MYROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export TASKEIRO=$(dirname "$MYROOT")/taskeiro

function sample_run() {
  >&2 echo '-----------------------'
  >&2 echo "SAMPLE RUN: $TASKEIRO $@"
  >&2 echo '-----------------------'
  $TASKEIRO "$@"
}

sample_run --help
