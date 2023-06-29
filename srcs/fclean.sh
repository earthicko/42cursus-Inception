#!/bin/bash

if [ "$SUDO_USER" ]; then
    REAL_USER=$SUDO_USER
else
    REAL_USER=$(whoami)
fi

HOME_DIR=$(eval echo ~$REAL_USER)

echo "HOME_DIR is $HOME_DIR"

rm -rf $HOME_DIR/data

sed -i '/donghyle.42.fr/d' /etc/hosts
