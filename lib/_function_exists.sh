function _function_exists() {
  type "$1" 2> /dev/null > /dev/null
}
export -f _function_exists
