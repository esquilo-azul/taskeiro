export FG_CYAN='\e[36m'
export BG_RED='\e[41m'
export NC='\033[0m' # No Color

function _fatal_error() {
  >&2 printf "$BG_RED$1$NC\n"
  exit 1
}

function _infov() {
  >&2 printf "$FG_CYAN$1:$NC $2\n"
}
