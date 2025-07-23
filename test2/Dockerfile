#ARG SUNSHINE_VERSION=latest
#ARG SUNSHINE_OS=ubuntu-22.04
#FROM lizardbyte/sunshine:${SUNSHINE_VERSION}-${SUNSHINE_OS}
ARG BASE=ubuntu:jammy 
FROM $BASE

USER root
 # Update packages and install prerequisites
RUN  apt update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       curl \
       gnupg \
       ca-certificates \
       dumb-init \
       git \
       git-lfs \
       htop \
       locales \
       lsb-release \
       nano \
       openssh-server \
       procps \
       sudo \
       wget \
       zsh \
       libgbm1 \
       libva2 \
       libva-drm2 \
       miniupnpc \
       libayatana-appindicator3-1 \
       libgbm1 \
      libva2 \
      libva-drm2 \
      miniupnpc \
      libayatana-appindicator3-1 \
      libevdev2 \
      libnuma1 \
      libopus0 \
      libpulse0 \
      libnotify4 \
      xvfb \
      x11-utils \
      ffmpeg \
  && git lfs install \
  && locale-gen en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*


# Install ZeroTier VPN
RUN curl -s https://install.zerotier.com | bash

# Install Sunshine
RUN wget -O  sunshine.deb https://github.com/LizardByte/Sunshine/releases/download/v2025.719.143211/sunshine-ubuntu-22.04-amd64.deb
RUN dpkg -i sunshine.deb


# Set locale
RUN sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen \
  && locale-gen
ENV LANG=en_US.UTF-8


# Create a user and configure their environment
RUN useradd -l -u 1001 -G sudo -md /home/gamer -s /bin/bash -p gamer gamer \
    && sed -i.bkp -e '/Defaults\tuse_pty/d' -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers


# sets the password for david
RUN echo 'gamer:gamer' | chpasswd

# open this ports
EXPOSE 22

# whichs to the gamer user and goes to /home/gamer
USER gamer
WORKDIR /home/gamer

RUN mkdir -p /home/gamer/.config
# copies the bashrc
COPY .bashrc /home/gamer

SHELL ["/bin/bash", "-c"]



# copies the starter file and make it executable
COPY start_services.sh /usr/local/bin/start_services.sh
RUN sudo chmod +x /usr/local/bin/start_services.sh

# runs the file
CMD ["/usr/local/bin/start_services.sh"]