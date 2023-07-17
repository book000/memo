#!/bin/sh

pip3 install --no-cache-dir -r requirements.txt

yarn install --frozen-lockfile
yarn cache clean
