./setup.sh
source .venv/bin/activate
uv run --with jupyter jupyter lab --notebook-dir=. --ip=0.0.0.0 --port=8888 --no-browser --IdentityProvider.token="$(TOKEN)"
