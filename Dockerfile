FROM ubuntu:latest as setup
ARG USER=remote
ARG TARGETARCH

# Create an interactive, non-expiring user with passwordless sudo. Log in using
# SSH keys.
RUN apt-get update && apt-get install -y sudo
RUN groupadd --gid 1000 $USER
RUN useradd --system --uid 1000 --gid $USER --groups sudo --create-home --home-dir /home/$USER --shell /bin/bash $USER
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Allow apt-get build-dep
RUN sed -i '/^#\sdeb-src /s/^# *//' "/etc/apt/sources.list"

RUN apt-get update && apt-get install -y wget
USER $USER
WORKDIR /home/$USER

FROM setup as deps
COPY init init
RUN init/01-git.sh
RUN init/10-devtools.sh

FROM setup as fzf
COPY init init
RUN init/01-git.sh
RUN mkdir x
RUN DEST=$HOME init/21-fzf.sh

FROM setup as install
COPY . .
RUN overwrite_all=true init/install.sh

FROM setup as bootstrap
ARG GITHUB_REF_NAME
ENV GITHUB_REF_NAME ${GITHUB_REF_NAME}
ARG GITHUB_REF
ENV GITHUB_REF ${GITHUB_REF}

RUN sudo apt-get install -y curl
RUN export overwrite_all=true && curl -s https://raw.githubusercontent.com/shoover/dotfiles/${GITHUB_REF_NAME}/init/bootstrap.sh | bash
