#syntax=docker/dockerfile:1
FROM debian:stable-slim as build

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

# install gpg keys
RUN gpg --batch --keyserver keys.openpgp.org --recv-keys 7D1E8AFD1D4A16D71FADA2F2CCC85C0E40C06A8C
RUN gpg --batch --keyserver keys.openpgp.org --recv-keys FE5AB6C91FEA597C3B31180B73EDE9E8CFBAEF01

# install ghcup
RUN \
    curl https://downloads.haskell.org/~ghcup/x86_64-linux-ghcup > /usr/bin/ghcup && \
    chmod +x /usr/bin/ghcup && \
    ghcup config set gpg-setting GPGStrict

ARG GHC=9.0.2
ARG STACK=2.11.1

# install GHC and stack
RUN \
    ghcup -v install ghc --isolate /usr/local --force ${GHC} && \
    ghcup -v install stack --isolate /usr/local/bin --force ${STACK}

# prepare environment
WORKDIR /thisisme/
COPY . .
RUN stack setup
RUN stack install --local-bin-path / # final executable will be copied to root

# now we copy over only the files we need to the final image
FROM debian:stable-slim
WORKDIR /thisisme/
COPY --from=build ThisIsMe thisisme
COPY public/ .
RUN mkdir logs/

CMD ["./thisisme", ">", "logs/$(date", "+\"%m-%d-%Y_%H:%M:%S\").log"]
