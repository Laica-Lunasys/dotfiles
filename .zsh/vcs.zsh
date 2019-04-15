setopt prompt_subst

### VCS Info
zstyle ':vcs_info:*' enable git svn hg bzr

zstyle ':vcs_info:git:*' get-revision true
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+" # %c
zstyle ':vcs_info:git:*' unstagedstr "-" # %u
zstyle ':vcs_info:git:*' formats '%b %u%c' '%m '
zstyle ':vcs_info:git:*' actionformats '(%s) %b %u%c%m' '<!%a>'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git+set-message:*' hooks \
                                     git-hook-begin \
                                     git-untracked \
                                     git-push-status \
                                     git-nomerge-branch \
                                     git-stash-count
precmd () {
    vcs_info
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

function +vi-git-hook-begin() {
    if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
        return 1
    fi
    return 0
}
function +vi-git-untracked() {
    if [[ "$1" != "1" ]]; then
        return 0
    fi
    if command git status --porcelain 2> /dev/null \
        | awk '{print $1}' \
        | command grep -F '??' > /dev/null 2>&1 ; then

        # %u
        hook_com[unstaged]+='?'
    fi
}
    function +vi-git-push-status() {
    if [[ "$1" != "1" ]]; then
        return 0
    fi
    if [[ "${hook_com[branch]}" != "master" ]]; then
        # only master branch
        return 0
    fi
    # get non-push commits
    local ahead
    ahead=$(command git rev-list origin/master..master 2>/dev/null \
        | wc -l \
        | tr -d ' ')
    if [[ "$ahead" -gt 0 ]]; then
        hook_com[misc]+="(${ahead}↑)"
    fi
}
function +vi-git-nomerge-branch() {
    if [[ "$1" != "1" ]]; then
        return 0
    fi
    if [[ "${hook_com[branch]}" == "master" ]]; then
        return 0
    fi
    local nomerged
    nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')
    if [[ "$nomerged" -gt 0 ]] ; then
        hook_com[misc]+="(M${nomerged})"
    fi
}
function +vi-git-stash-count() {
    if [[ "$1" != "1" ]]; then
        return 0
    fi
    local stash
    stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
    if [[ "${stash}" -gt 0 ]]; then
        hook_com[misc]+=":S${stash}"
    fi
}
