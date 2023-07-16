#!/bin/sh

git config --global --add safe.directory /workspaces/memo
mkdocs serve --dev-addr=0.0.0.0:8080
