### VCS Info
zstyle ':vcs_info:git:*' get-revision true
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr "${Gray1} | %F${fg[white]}+%f"
zstyle ':vcs_info:git:*' stagedstr "${Gray1} | %F${fg[white]}!%f"
zstyle ':vcs_info:*' formats " ⌥ %b%u%c %f"
zstyle ':vcs_info:*' actionformats " ⌥ %b%u%c%a %f"
zstyle ':vcs_info:git+set-message:*' hooks \
                                     git-hook-begin \
                                     git-untracked \
                                     git-push-status \
                                     git-nomerge-branch \
                                     git-stash-count
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}