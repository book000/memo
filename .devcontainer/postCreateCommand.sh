#!/bin/bash

sudo git config --system --add safe.directory ${containerWorkspaceFolder}
sudo chown vscode node_modules .pnpm-store

pip3 install --no-cache-dir -r requirements.txt

pnpm install --frozen-lockfile --prefer-frozen-lockfile
