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
    fuse \
    software-properties-common \
  && git lfs install \
  && sudo dpkg --add-architecture i386 \
  && sudo apt-get update \
  && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    steam 


# Install ZeroTier VPN
RUN curl -s https://install.zerotier.com | bash



# Set locale
RUN sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen \
  && locale-gen
ENV LANG=en_US.UTF-8


# Create a user and configure their environment
RUN useradd -l -u 1000 -G sudo -md /home/gamer -s /bin/bash -p gamer gamer \
    && sed -i.bkp -e '/Defaults\tuse_pty/d' -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers


# sets the password for david
RUN echo 'gamer:gamer' | chpasswd

# open this ports
EXPOSE 22
EXPOSE 47984-47990/tcp
EXPOSE 47998-48000/udp
EXPOSE 48010
EXPOSE 27031/udp
EXPOSE 27036/udp
EXPOSE 27036/tcp
EXPOSE 27037/tcp

# whichs to the gamer user and goes to /home/gamer
USER gamer
WORKDIR /home/gamer

# copies the bashrc
COPY .bashrc /home/gamer

SHELL ["/bin/bash", "-c"]

# copies the starter file and make it executable
COPY start_services.sh /usr/local/bin/start_services.sh
RUN sudo chmod +x /usr/local/bin/start_services.sh

# runs the file
CMD ["/usr/local/bin/start_services.sh"]