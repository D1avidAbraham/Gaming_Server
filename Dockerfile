# Use Ubuntu 22.04 as the base image
ARG BASE=ubuntu:jammy

FROM $BASE


# Update packages and install prerequisites
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-utils \
    build-essential \
    manpages-dev \
    xfce4 \
    xfce4-goodies \
    dbus-x11 \
    x11-xserver-utils \
    xterm \
    npm \
    nodejs \ 
    default-jre \
    gnupg \
    curl \
    dumb-init \
    git \
    git-lfs \
    htop \
    locales \
    lsb-release \
    man-db \
    python3 \
    nano \
    openssh-client \
    openssh-server \
    procps \
    sudo \
    vim-tiny \
    wget \
    zsh \
    clang \
    mono-complete \
    iproute2 \
    net-tools \
    ssl-cert \
    libswitch-perl \
    libyaml-tiny-perl \
    libhash-merge-simple-perl \
    liblist-moreutils-perl \
    libdatetime-timezone-perl \
    dialog \
  && git lfs install


# Install ZeroTier VPN
RUN curl -s https://install.zerotier.com | bash