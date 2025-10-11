FROM archlinux:latest

ARG USERNAME=relias
ENV TERM=xterm-256color
ENV LANG=C.UTF-8

RUN pacman -Syy && \
    pacman -S --noconfirm --needed \
    busybox git tmux vim neovim zsh make gcc nano curl wget sudo tzdata

RUN busybox --install && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    useradd ${USERNAME} -m -G wheel -s /bin/zsh && \
    usermod -aG wheel ${USERNAME}

USER ${USERNAME}

COPY --chown=${USERNAME} . /home/${USERNAME}/dotfiles
WORKDIR /home/${USERNAME}/dotfiles
RUN make install

WORKDIR /home/${USERNAME}
CMD ["/bin/zsh"]
