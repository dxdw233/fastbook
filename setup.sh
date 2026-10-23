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

uv pip install -r requirements.txt jupyterlab fastbook
