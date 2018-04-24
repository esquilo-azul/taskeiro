function task_condition() {
  stat "$SAMPLE_TEMP_DIR/file1" > /dev/null 2> /dev/null
}

function task_fix() {
  touch "$SAMPLE_TEMP_DIR/file1"
}
