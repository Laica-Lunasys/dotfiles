#    merge  merge in progress
#      ~42  42 merge conflicts
#      +42  42 staged changes
#      !42  42 unstaged changes
#      ?42  42 untracked files
function gitstatus_prompt_update() {
  emulate -L zsh
  typeset -g  GITSTATUS_PROMPT=''
  typeset -gi GITSTATUS_PROMPT_LEN=0

  # Call gitstatus_query synchronously. Note that gitstatus_query can also be called
  # asynchronously; see documentation in gitstatus.plugin.zsh.
  gitstatus_query 'MY'                  || return 1  # error
  # [[ $VCS_STATUS_RESULT == 'ok-sync' ]] || return 0  # not a git repo
  
  export PROMPT_VCS_STATUS_ACTION="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_ACTION != "0" ]] && echo $VCS_STATUS_ACTION || echo -ne '')"
  export PROMPT_VCS_STATUS_COMMIT="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_COMMIT != "0" ]] && echo $VCS_STATUS_COMMIT || echo -ne '')"
  export PROMPT_VCS_STATUS_COMMITS_AHEAD="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_COMMITS_AHEAD != "0" ]] && echo $VCS_STATUS_COMMITS_AHEAD || echo -ne '')"
  export PROMPT_VCS_STATUS_COMMITS_BEHIND="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_COMMITS_BEHIND != "0" ]] && echo $VCS_STATUS_COMMITS_BEHIND || echo -ne '')"
  export PROMPT_VCS_STATUS_COMMIT_ENCODING="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_COMMIT_ENCODING != "0" ]] && echo $VCS_STATUS_COMMIT_ENCODING || echo -ne '')"
  export PROMPT_VCS_STATUS_COMMIT_SUMMARY="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_COMMIT_SUMMARY != "0" ]] && echo $VCS_STATUS_COMMIT_SUMMARY || echo -ne '')"
  export PROMPT_VCS_STATUS_HAS_CONFLICTED="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_HAS_CONFLICTED != "0" ]] && echo $VCS_STATUS_HAS_CONFLICTED || echo -ne '')"
  export PROMPT_VCS_STATUS_HAS_STAGED="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_HAS_STAGED != "0" ]] && echo $VCS_STATUS_HAS_STAGED || echo -ne '')"
  export PROMPT_VCS_STATUS_HAS_UNSTAGED="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_HAS_UNSTAGED != "0" ]] && echo $VCS_STATUS_HAS_UNSTAGED || echo -ne '')"
  export PROMPT_VCS_STATUS_HAS_UNTRACKED="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_HAS_UNTRACKED != "0" ]] && echo $VCS_STATUS_HAS_UNTRACKED || echo -ne '')"
  export PROMPT_VCS_STATUS_INDEX_SIZE="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_INDEX_SIZE != "0" ]] && echo $VCS_STATUS_INDEX_SIZE || echo -ne '')"
  export PROMPT_VCS_STATUS_LOCAL_BRANCH="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_LOCAL_BRANCH != "0" ]] && echo $VCS_STATUS_LOCAL_BRANCH || echo -ne '')"
  export PROMPT_VCS_STATUS_NUM_ASSUME_UNCHANGED="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_NUM_ASSUME_UNCHANGED != "0" ]] && echo $VCS_STATUS_NUM_ASSUME_UNCHANGED || echo -ne '')"
  export PROMPT_VCS_STATUS_NUM_CONFLICTED="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_NUM_CONFLICTED != "0" ]] && echo $VCS_STATUS_NUM_CONFLICTED || echo -ne '')"
  export PROMPT_VCS_STATUS_NUM_STAGED="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_NUM_STAGED != "0" ]] && echo $VCS_STATUS_NUM_STAGED || echo -ne '')"
  export PROMPT_VCS_STATUS_NUM_UNSTAGED="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_NUM_UNSTAGED != "0" ]] && echo $VCS_STATUS_NUM_UNSTAGED || echo -ne '')"
  export PROMPT_VCS_STATUS_NUM_SKIP_WORKTREE="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_NUM_SKIP_WORKTREE != "0" ]] && echo $VCS_STATUS_NUM_SKIP_WORKTREE || echo -ne '')"
  export PROMPT_VCS_STATUS_NUM_STAGED_NEW="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_NUM_STAGED_NEW != "0" ]] && echo $VCS_STATUS_NUM_STAGED_NEW || echo -ne '')"
  export PROMPT_VCS_STATUS_NUM_STAGED_DELETED="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_NUM_STAGED_DELETED != "0" ]] && echo $VCS_STATUS_NUM_STAGED_DELETED || echo -ne '')"
  export PROMPT_VCS_STATUS_NUM_UNSTAGED_DELETED="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_NUM_UNSTAGED_DELETED != "0" ]] && echo $VCS_STATUS_NUM_UNSTAGED_DELETED || echo -ne '')"
  export PROMPT_VCS_STATUS_NUM_UNTRACKED="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_NUM_UNTRACKED != "0" ]] && echo $VCS_STATUS_NUM_UNTRACKED || echo -ne '')"
  export PROMPT_VCS_STATUS_PUSH_COMMITS_AHEAD="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_PUSH_COMMITS_AHEAD != "0" ]] && echo $VCS_STATUS_PUSH_COMMITS_AHEAD || echo -ne '')"
  export PROMPT_VCS_STATUS_PUSH_COMMITS_BEHIND="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_PUSH_COMMITS_BEHIND != "0" ]] && echo $VCS_STATUS_PUSH_COMMITS_BEHIND || echo -ne '')"
  export PROMPT_VCS_STATUS_PUSH_REMOTE_NAME="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_PUSH_REMOTE_NAME != "0" ]] && echo $VCS_STATUS_PUSH_REMOTE_NAME || echo -ne '')"
  export PROMPT_VCS_STATUS_PUSH_REMOTE_URL="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_PUSH_REMOTE_URL != "0" ]] && echo $VCS_STATUS_PUSH_REMOTE_URL || echo -ne '')"
  export PROMPT_VCS_STATUS_REMOTE_BRANCH="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_REMOTE_BRANCH != "0" ]] && echo $VCS_STATUS_REMOTE_BRANCH || echo -ne '')"
  export PROMPT_VCS_STATUS_REMOTE_NAME="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_REMOTE_NAME != "0" ]] && echo $VCS_STATUS_REMOTE_NAME || echo -ne '')"
  export PROMPT_VCS_STATUS_REMOTE_URL="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_REMOTE_URL != "0" ]] && echo $VCS_STATUS_REMOTE_URL || echo -ne '')"
  export PROMPT_VCS_STATUS_RESULT="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_RESULT != "0" ]] && echo $VCS_STATUS_RESULT || echo -ne '')"
  export PROMPT_VCS_STATUS_STASHES="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_STASHES != "0" ]] && echo $VCS_STATUS_STASHES || echo -ne '')"
  export PROMPT_VCS_STATUS_TAG="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_TAG != "0" ]] && echo $VCS_STATUS_TAG || echo -ne '')"
  export PROMPT_VCS_STATUS_WORKDIR="$([[ $VCS_STATUS_RESULT == "ok-sync" ]] && [[ $VCS_STATUS_WORKDIR != "0" ]] && echo $VCS_STATUS_WORKDIR || echo -ne '')"
  
  # local      clean=''   # green foreground
  # local   modified=''  # yellow foreground
  # local  untracked=''   # blue foreground
  # local conflicted=''  # red foreground

  # local p

  # local where  # branch name, tag or commit
  # if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
  #   where=$VCS_STATUS_LOCAL_BRANCH
  # elif [[ -n $VCS_STATUS_TAG ]]; then
  #   p+='%f#'
  #   where=$VCS_STATUS_TAG
  # else
  #   p+='%f@'
  #   where=${VCS_STATUS_COMMIT[1,8]}
  # fi

  # (( $#where > 32 )) && where[13,-13]="…"  # truncate long branch names and tags
  # p+="${clean}${where//\%/%%}"             # escape %

  # # ⇣42 if behind the remote.
  # (( VCS_STATUS_COMMITS_BEHIND )) && p+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
  # # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
  # (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && p+=" "
  # (( VCS_STATUS_COMMITS_AHEAD  )) && p+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
  # # ⇠42 if behind the push remote.
  # (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
  # (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" "
  # # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
  # (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && p+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
  # # *42 if have stashes.
  # (( VCS_STATUS_STASHES        )) && p+=" ${clean}*${VCS_STATUS_STASHES}"
  # # 'merge' if the repo is in an unusual state.
  # [[ -n $VCS_STATUS_ACTION     ]] && p+=" ${conflicted}${VCS_STATUS_ACTION}"
  # # ~42 if have merge conflicts.
  # (( VCS_STATUS_NUM_CONFLICTED )) && p+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
  # # +42 if have staged changes.
  # (( VCS_STATUS_NUM_STAGED     )) && p+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
  # # !42 if have unstaged changes.
  # (( VCS_STATUS_NUM_UNSTAGED   )) && p+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
  # # ?42 if have untracked files. It's really a question mark, your font isn't broken.
  # (( VCS_STATUS_NUM_UNTRACKED  )) && p+=" ${untracked}?${VCS_STATUS_NUM_UNTRACKED}"

  # export GITSTATUS_PROMPT="${p}%f"

  # # The length of GITSTATUS_PROMPT after removing %f and %F.
  # GITSTATUS_PROMPT_LEN="${(m)#${${GITSTATUS_PROMPT//\%\%/x}//\%(f|<->F)}}"
}

# Start gitstatusd instance with name "MY". The same name is passed to
# gitstatus_query in gitstatus_prompt_update. The flags with -1 as values
# enable staged, unstaged, conflicted and untracked counters.
gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'

# On every prompt, fetch git status and set GITSTATUS_PROMPT.
# autoload -Uz add-zsh-hook
add-zsh-hook precmd gitstatus_prompt_update

# Enable/disable the right prompt options.
setopt no_prompt_bang prompt_percent prompt_subst

# Customize prompt. Put $GITSTATUS_PROMPT in it to reflect git status.
#
# Example:
#
#   user@host ~/projects/skynet master ⇡42
#   % █
#
# The current directory gets truncated from the left if the whole prompt doesn't fit on the line.
#'${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT}'      # git status

