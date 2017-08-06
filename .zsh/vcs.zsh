### VCS Info
zstyle ':vcs_info:git:*' get-revision true
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr " | %F${fg[white]}!"
zstyle ':vcs_info:git:*' unstagedstr " | %F${fg[white]}+"
zstyle ':vcs_info:*' formats " ⌥ %b%u%a "
zstyle ':vcs_info:*' actionformats "[%b|%a %r]b"
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