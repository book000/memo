FROM mcr.microsoft.com/devcontainers/base:alpine-3.18

# hadolint ignore=DL3018
RUN apk update && apk add --no-cache \
    python3 \
    nodejs \
    npm \
    git \
    openssh-client \
    python3-dev \
    py3-pip \
    build-base \
    pngquant \
    && rm -rf /var/cache/apk/* \
    && npm i -g pnpm

WORKDIR /work
