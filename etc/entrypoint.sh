#!/usr/bin/env bash
set -e

MAP_NODE_UID=$PWD

export USER=developer

usermod -u ${USER_UID} ${USER} 2> /dev/null && {
  groupmod -g ${USER_GID} ${USER} 2> /dev/null || usermod -a -G ${USER_GID} ${USER}
} || useradd -u "${USER_UID}" -s /bin/bash -d /var/www/html ${USER}

usermod -a -G sudo ${USER}

if [[ "" == "$@" ]]; then
  exec nginx -g "daemon off;"
  exit
fi

echo "gosudo ${USER} with ${USER_UID}:${USER_GID}"
exec gosu ${USER} "$@"
