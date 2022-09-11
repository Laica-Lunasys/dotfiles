FROM ubuntu:22.04

ARG USERNAME=relias
ENV TERM xterm-256color
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND nointeractive

RUN apt-get update -qq && \
    apt-get install -y \
    busybox git tmux vim zsh make gcc g++ nano curl wget sudo tzdata nmap \
    python3 python3-pip golang \
    software-properties-common

# Install neovim
RUN add-apt-repository ppa:neovim-ppa/stable && \
    apt-get update -qq && \
    apt-get install -y neovim

# Clean
RUN apt-get clean

RUN busybox --install && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    useradd ${USERNAME} -m -u 1000 -G sudo -s /bin/zsh && \
    usermod -aG sudo ${USERNAME}

USER ${USERNAME}

COPY --chown=${USERNAME}:1000 . /home/${USERNAME}/dotfiles
WORKDIR /home/${USERNAME}/dotfiles
RUN make install

WORKDIR /home/${USERNAME}
CMD ["/bin/zsh"]
