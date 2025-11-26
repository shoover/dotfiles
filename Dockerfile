ARG DISTRO=ubuntu
FROM $DISTRO:latest AS setup

ARG USER=remote

# Any uid will work. We don't need to hassle with bind mounts as in
# https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user
ARG USER_UID=4242
ARG USER_GID=$USER_UID
ARG TARGETARCH

# Allow apt-get build-dep. Debian intentionally excludes deb-src lines from docker builds,
# which breaks breaks apt-get build-dep emacs.
RUN find /etc/apt/sources.list* -type f -exec sed -i 's/^Types: deb$/Types: deb deb-src/' {} +

RUN apt-get update && apt-get install -y sudo wget

# Create a non-root user with passwordless sudo to test install scripts as a
# normal user.
RUN groupadd --gid $USER_GID $USER || groupmod --gid $USER_GID $USER
RUN useradd --system --uid $USER_UID --gid $USER --groups sudo --create-home --home-dir /home/$USER --shell /bin/bash $USER
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER
WORKDIR /home/$USER

FROM setup AS install
COPY . .
RUN overwrite_all=true init/install.sh

FROM setup AS bootstrap
ARG GITHUB_REF
ENV GITHUB_REF=${GITHUB_REF}
ARG GITHUB_REF_NAME
ENV GITHUB_REF_NAME=${GITHUB_REF_NAME}

RUN sudo apt-get install -y curl
RUN export overwrite_all=true && curl -s https://raw.githubusercontent.com/shoover/dotfiles/${GITHUB_REF_NAME}/init/bootstrap.sh | bash
