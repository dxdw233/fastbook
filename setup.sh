#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

VENV_DIR="${VENV_DIR:-.venv}"
PORT="${PORT:-8888}"
HOST="${HOST:-0.0.0.0}"
PYTHON_VERSION="${PYTHON:-3.11}"
JUPYTER_TOKEN="${JUPYTER_TOKEN:-}"

if [ "${1:-}" = "--reset" ]; then
    echo "removing $VENV_DIR"
    rm -rf "$VENV_DIR"
    shift
fi

if [ ! -d "$VENV_DIR" ]; then
    echo "creating virtualenv in $VENV_DIR (python $PYTHON_VERSION)"
    uv venv "$VENV_DIR" --python "$PYTHON_VERSION"
fi

if [ ! -f "$VENV_DIR/bin/activate" ]; then
    echo "can't activate venv" >&2
    exit 1
fi

source "$VENV_DIR/bin/activate"

uv pip install -r requirements.txt
uv pip install jupyterlab

JUPYTER_ARGS=(--no-browser --ip="$HOST" --port="$PORT" --ServerApp.root_dir="$PWD" --ServerApp.allow_remote_access=True)

exec nohup uv run --no-project jupyter lab "${JUPYTER_ARGS[@]}" "$@"
