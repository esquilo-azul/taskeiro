function taskeiro_add_dependency() {
  local TARGET="$1"
  shift
  for DEPENDENCY in "$@"; do
    _extra_dependencies_add "$TARGET" "$DEPENDENCY"
  done
}
export -f taskeiro_add_dependency
