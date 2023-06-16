#!/bin/bash
set -e

cd "$(dirname "$0")" || exit
cd ..

# check exists venv
if [ ! -d "venv" ]; then
  python3 -m venv venv
fi

# activate venv
source venv/bin/activate
pip install -r requirements.txt

mkdocs serve --dev-addr=0.0.0.0:8080