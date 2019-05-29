FROM ubuntu:19.04

ARG USERNAME=relias
ENV TERM xterm-256color
ENV LANG C.UTF-8

RUN apt-get update -qq && \
    apt-get install -y busybox git tmux vim zsh make nano curl wget sudo && \
    apt-get clean && \
    busybox --install && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    useradd ${USERNAME} -m -u 1000 -G sudo -s /bin/zsh && \
    usermod -aG sudo ${USERNAME}

COPY . /home/${USERNAME}/dotfiles
RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/dotfiles

USER ${USERNAME}
WORKDIR /home/${USERNAME}

RUN cd /home/${USERNAME}/dotfiles && \
    make install

CMD ["/bin/zsh"]
