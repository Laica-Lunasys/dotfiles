# Simple Zsh prompt with Git status.

# Source gitstatus.plugin.zsh from $GITSTATUS_DIR or from the same directory
# in which the current script resides if the variable isn't set.

# Sets GITSTATUS_PROMPT to reflect the state of the current git repository. Empty if not
# in a git repository. In addition, sets GITSTATUS_PROMPT_LEN to the number of columns
# $GITSTATUS_PROMPT will occupy when printed.
#
# Example:
#
#   GITSTATUS_PROMPT='master ⇣42⇡42 ⇠42⇢42 *42 merge ~42 +42 !42 ?42'
#   GITSTATUS_PROMPT_LEN=39
#
#   master  current branch
#      ⇣42  local branch is 42 commits behind the remote
#      ⇡42  local branch is 42 commits ahead of the remote
#      ⇠42  local branch is 42 commits behind the push remote
#      ⇢42  local branch is 42 commits ahead of the push remote
#      *42  42 stashes
#    merge  merge in progress
#      ~42  42 merge conflicts
#      +42  42 staged changes
#      !42  42 unstaged changes
#      ?42  42 untracked files
function gitstatus_prompt_update() {
  export PROMPT_VCS_STATUS=""
  emulate -L zsh
  typeset -g GITSTATUS_PROMPT=''
  typeset -gi GITSTATUS_PROMPT_LEN=0

  # Call gitstatus_query synchronously. Note that gitstatus_query can also be called
  # asynchronously; see documentation in gitstatus.plugin.zsh.
  gitstatus_query 'MY' || return 1                  # error
  [[ $VCS_STATUS_RESULT == 'ok-sync' ]] || return 0 # not a git repo

  local clean='%76F'       # green foreground
  local modified='%178F'   # yellow foreground
  local untracked='%39F'   # blue foreground
  local conflicted='%196F' # red foreground

  local p

  local where # branch name, tag or commit
  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
    where=$VCS_STATUS_LOCAL_BRANCH
  elif [[ -n $VCS_STATUS_TAG ]]; then
    p+='%f#'
    where=$VCS_STATUS_TAG
  else
    p+='%f@'
    where=${VCS_STATUS_COMMIT[1, 8]}
  fi

  (($#where > 32)) && where[13, -13]="…" # truncate long branch names and tags
  p+="${clean}${where//\%/%%}"           # escape %

  # ⇣42 if behind the remote.
  ((VCS_STATUS_COMMITS_BEHIND)) && p+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
  # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
  ((VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND)) && p+=" "
  ((VCS_STATUS_COMMITS_AHEAD)) && p+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
  # ⇠42 if behind the push remote.
  ((VCS_STATUS_PUSH_COMMITS_BEHIND)) && p+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
  ((VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND)) && p+=" "
  # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
  ((VCS_STATUS_PUSH_COMMITS_AHEAD)) && p+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
  # *42 if have stashes.
  ((VCS_STATUS_STASHES)) && p+=" ${clean}*${VCS_STATUS_STASHES}"
  # 'merge' if the repo is in an unusual state.
  [[ -n $VCS_STATUS_ACTION ]] && p+=" ${conflicted}${VCS_STATUS_ACTION}"
  # ~42 if have merge conflicts.
  ((VCS_STATUS_NUM_CONFLICTED)) && p+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
  # +42 if have staged changes.
  ((VCS_STATUS_NUM_STAGED)) && p+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
  # !42 if have unstaged changes.
  ((VCS_STATUS_NUM_UNSTAGED)) && p+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
  # ?42 if have untracked files. It's really a question mark, your font isn't broken.
  ((VCS_STATUS_NUM_UNTRACKED)) && p+=" ${untracked}?${VCS_STATUS_NUM_UNTRACKED}"

  p+='%f' # reset color
  export PROMPT_VCS_STATUS=$(print -P "${p}")

  # The length of GITSTATUS_PROMPT after removing %f and %F.
  # GITSTATUS_PROMPT_LEN="${(m)#${${GITSTATUS_PROMPT//\%\%/x}//\%(f|<->F)}}"

  print "${PROMPT_VCS_STATUS}"
}

# Start gitstatusd instance with name "MY". The same name is passed to
# gitstatus_query in gitstatus_prompt_update. The flags with -1 as values
# enable staged, unstaged, conflicted and untracked counters.
gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'

# add-zsh-hook precmd gitstatus_prompt_update

gitstatus_hook() {
  export PROMPT_VCS_STATUS="$3"
  zle reset-prompt
}

gitstatus_update_prompt() {
  # export PROMPT_VCS_STATUS="A"
  gitstatus_prompt_update

  # print ${PROMPT_VCS_STATUS}
  # echo "OK"
}

function update_dir() {
  if [[ "$PWD" != "$1" ]]; then
    cd "$1"
  fi

  gitstatus_prompt_update
}

async_init
async_start_worker gitstatus_async
async_register_callback gitstatus_async gitstatus_hook
# async_job gitstatus_async gitstatus_update_prompt
async_worker_eval gitstatus_async update_dir $PWD

gitstatus_precmd() {
  async_worker_eval gitstatus_async update_dir $PWD
  # async_start_worker gitstatus_async
  # async_register_callback gitstatus_async gitstatus_hook
  # async_job gitstatus_async gitstatus_update_prompt
}

# On every prompt, fetch git status and set GITSTATUS_PROMPT.
# add-zsh-hook precmd gitstatus_precmd
precmd() {
  gitstatus_precmd
}

# Enable/disable the right prompt options.
setopt no_prompt_bang prompt_percent prompt_subst
