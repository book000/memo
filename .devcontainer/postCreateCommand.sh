#!/bin/sh

pip3 install --no-cache-dir -r requirements.txt

pnpm install  --frozen-lockfile --prefer-frozen-lockfile
