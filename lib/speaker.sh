# https://misc.flogisoft.com/bash/tip_colors_and_formatting
export FG_LGREEN='\e[92m'
export FG_LRED='\e[91m'
export FG_LYELLOW='\e[93m'
export FG_LBLUE='\e[94m'
export NC='\033[0m' # No Color

function _success() {
  outerr "${FG_LGREEN}" "$@" "${NC}\n"
}

function _debug() {
  if [ -n "$TASKEIRO_DEBUG" ]; then
    outerr "${FG_LBLUE}" "$@" "${NC}\n"
  fi
}
