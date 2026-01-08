### function to create a tmux session with 2 windows
## session should be started in particular directory

DIR_PREFIX="~/projects"

## safe directory name

function safe_dir_name() {
  local dir_name=$1
  local safe_dir_name=$(echo $dir_name | tr '/' '_')
  echo $safe_dir_name
}

function create_tmux_session() {
  local session_name=$1
  local working_directory=$2

  // check if session exists
  local session_exists=$(tmux list-sessions | grep $session_name)

  if [ -n "$session_exists" ]; then
    echo "session $session_name already exists. Noop"
    return 0
  fi

  tmux new-session -d -s $session_name -c $2
}

### remove a tmux session
function remove_tmux_session() {
  local session_name=$1

  tmux kill-session -t $session_name
}

function remove_current_tmux_session() {
  local session_name=$(tmux display-message -p '#S')

  tmux kill-session -t $session_name
}

function add_git_remote() {
  ## create remote if not exists

  local remote_name=$1
  local remote_url=$2

  remote_exists=$(git remote | grep $remote_name)
  if [ -n "$remote_exists" ]; then
    echo "remote $remote_name already exists. removing and re-adding"
    git remote remove $remote_name
  fi
  git remote add $remote_name $remote_url
}

function remove_git_remote() {
  local remote_name=$1

  git remote remove $remote_name
}

function create_worktree_pr() {
  echo "creating worktree based on pr"
  local pr_number=$1
  local branch_name=$(gh pr view $pr_number --json headRefName -q ".headRefName")
  local remote_owner=$(gh pr view $pr_number --json headRepositoryOwner -q ".headRepositoryOwner.login")
  local remote_url="https://github.com/$remote_owner/kibana"
  local safe_branch_name=$(safe_dir_name $branch_name)
  local worktree_name="kibana__$remote_owner__$safe_branch_name"
  local worktree_dir="$HOME/projects/$worktree_name"

  echo "Branch name: $branch_name"
  echo "Remote owner: $remote_owner"
  echo "Worktree name: $worktree_name"
  echo "Worktree dir: $worktree_dir"

  add_git_remote $remote_owner $remote_url
  git fetch $remote_owner $branch_name

  local worktree_exists=$(git worktree list | grep $worktree_name)

  // create worktree does not exists
  if [ -n "$worktree_exists" ]; then
    echo "worktree already exists."
  else
    echo "worktree does not exists. Creating"
    git worktree add $worktree_dir $branch_name
  fi

  create_tmux_session $worktree_name $worktree_dir
  echo "worktree created. Exiting"
}

function create_worktree_branch() {
  echo "creating worktree based on branch"
  local branch_name=$1
  local safe_branch_name=$(safe_dir_name $branch_name)
  local worktree_name="kibana__$safe_branch_name"
  local worktree_dir="$HOME/projects/$worktree_name"

  local worktree_exists=$(git worktree list | grep $worktree_name)

  // create worktree does not exists
  if [ -n "$worktree_exists" ]; then
    echo "worktree already exists."
  else
    echo "worktree does not exists. Creating"
    git worktree add $worktree_dir $branch_name
  fi

  create_tmux_session $worktree_name $worktree_dir
}

### function create a new worktree based on PR or a new branch
function create_worktree() {
  ## accept 2 named parameter branch and pr and default value is empty

  local branch_name=""
  local pr_number=""
  local OPTIND

  while getopts "b:p:" opt; do
    case $opt in
    b) branch_name=$OPTARG ;;
    p) pr_number=$OPTARG ;;
    \?)
      echo "Invalid option -$OPTARG"
      return 1
      ;;
    esac
  done

  echo "Branch name: $branch_name"
  echo "PR number: $pr_number"

  ## get the github remote url and branch name from the pr
  if [ -z $branch_name ] && [ -z $pr_number ]; then
    echo "branch name or pr number is required"
    return 1
  fi

  if [ -z $branch_name ]; then
    create_worktree_pr $pr_number
  else
    create_worktree_branch $branch_name
  fi

}

function remove_current_worktree() {
  git worktree remove $(pwd)
}

function remove_worktree() {
  remove_current_worktree && remove_current_tmux_session
}
