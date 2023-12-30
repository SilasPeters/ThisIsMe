FROM debian:stable-slim

# install dependencies
RUN \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
        curl \
        libnuma-dev \
        zlib1g-dev \
        libgmp-dev \
        libgmp10 \
        git \
        wget \
        lsb-release \
        software-properties-common \
        gnupg2 \
        apt-transport-https \
        gcc \
        autoconf \
        automake \
        build-essential

WORKDIR /root/ThisIsMe

ENV PATH="/root/.local/bin:/root/.cabal/bin:/root/.ghcup/bin:$PATH"
RUN echo "export PATH=${PATH}" >> /root/.profile

ENV BOOTSTRAP_HASKELL_GHC_VERSION=9.2.5
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1
ENV BOOTSTRAP_HASKELL_INSTALL_HLS=0
ENV BOOTSTRAP_HASKELL_ADJUST_BASHRC=0

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

COPY stack.yaml stack.yaml.lock ThisIsMe.cabal ./

RUN stack build --only-dependencies

COPY . .

CMD stack run
