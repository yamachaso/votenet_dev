#!/bin/bash

USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
useradd -u $USER_ID -o -m appuser
groupmod -g $GROUP_ID appuser
gpasswd -a appuser sudo
echo "appuser:password" | chpasswd
export HOME=/home/appuser

exec /usr/sbin/gosu appuser "$@"
