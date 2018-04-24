export TASKEIRO_ROOT=$(dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))
export TASKEIRO_EXECUTER="$0"
export TASKEIRO_PATH=

source "$TASKEIRO_ROOT/lib/speaker.sh"
source "$TASKEIRO_ROOT/lib/cli.sh"
