#!/bin/bash
set -euo pipefail

# Only run in Claude Code on the web (remote) environments.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR"

# Install the runtime dependencies declared in setup.py. The package itself is
# imported directly from the source tree via PYTHONPATH (Debian's patched
# setuptools rejects editable installs of this project).
python3 -m pip install \
  'pandas>=2.2.3' \
  numpy \
  requests \
  aiohttp \
  nest_asyncio

# Make the in-repo pydataxm package importable for the session.
echo "export PYTHONPATH=\"$CLAUDE_PROJECT_DIR\"" >> "$CLAUDE_ENV_FILE"
