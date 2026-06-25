export TASKEIRO_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export TASKEIRO_EXECUTER="$0"
export TASKEIRO_PATH=
export TASKEIRO_TASKS=
export TASKEIRO_DEBUG="${TASKEIRO_DEBUG:-}"
export TASKEIRO_CHECKED_TASKS='|'
hash_init 'EXTRA_DEPENDENCIES'

for file in "${TASKEIRO_ROOT}/lib/"*.sh; do
  source "$file"
done
