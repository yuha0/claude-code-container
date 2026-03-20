#!/bin/sh
# source: https://github.com/nezhar/claude-container/blob/f00bc16a7933a8de4f63e3160d3d0c32b5579f19/claude-code/entrypoint.sh

set -e

USER_UID=${USER_UID:-1000}
USER_GID=${USER_GID:-1000}

export SHELL=/bin/sh

if [ "$USER_UID" -eq 0 ]; then
    exec claude "$@"
fi

if ! getent group "$USER_GID" >/dev/null 2>&1; then
    addgroup -g "$USER_GID" claude 2>/dev/null || true
    GROUP_NAME="claude"
else
    GROUP_NAME=$(getent group "$USER_GID" | cut -d: -f1)
fi

if ! getent passwd "$USER_UID" >/dev/null 2>&1; then
    adduser -D -u "$USER_UID" -G "$GROUP_NAME" -h /home/claude -s /bin/sh claude 2>/dev/null || true
    USER_NAME="claude"
else
    USER_NAME=$(getent passwd "$USER_UID" | cut -d: -f1)
fi

# Ensure config directory is accessible
if [ -d /claude ]; then
    chown "$USER_UID:$USER_GID" /claude 2>/dev/null || true
    chmod 755 /claude 2>/dev/null || true
fi

exec su-exec "$USER_NAME" claude "$@"
