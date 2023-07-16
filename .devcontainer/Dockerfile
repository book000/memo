FROM mcr.microsoft.com/devcontainers/base:alpine-3.18

# python & nodejs
# git (ssh)

# hadolint ignore=DL3018
RUN apk update && apk add --no-cache \
    python3 \
    nodejs \
    npm \
    yarn \
    git \
    openssh-client \
    && rm -rf /var/cache/apk/*

# hadolint ignore=DL3018
RUN apk update && apk add --no-cache \
    python3-dev \
    py3-pip \
    build-base \
    && rm -rf /var/cache/apk/*

WORKDIR /work

# install deps from requirements.txt
COPY ../requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# install deps from package.json
COPY ../package.json .
RUN yarn install --frozen-lockfile && \
    yarn cache clean
