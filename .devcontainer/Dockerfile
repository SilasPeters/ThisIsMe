FROM debian:trixie-slim AS devcontainer

# install dependencies
RUN \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libffi-dev \
        libffi8 \
        libgmp-dev \
        libgmp10 \
        libncurses-dev \
        libncurses6 \
        libtinfo6 \
        pkg-config \
        ca-certificates \
        zlib1g-dev \
        git


RUN useradd -m --uid 1000 haskell
USER 1000

ENV PATH="/home/haskell/.local/bin:/home/haskell/.cabal/bin:/home/haskell/.ghcup/bin:$PATH"
RUN echo "export PATH=${PATH}" >> /home/haskell/.profile
ENV BOOTSTRAP_HASKELL_GHC_VERSION=9.10.3
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1
ENV BOOTSTRAP_HASKELL_INSTALL_HLS=0
ENV BOOTSTRAP_HASKELL_ADJUST_BASHRC=0
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

RUN mkdir /home/haskell/workspace

# COPY stack.yaml stack.yaml.lock ThisIsMe.cabal ./

# RUN stack build --only-dependencies

