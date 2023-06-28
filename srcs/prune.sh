#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

if [ "$SUDO_USER" ]; then
    REAL_USER=$SUDO_USER
else
    REAL_USER=$(whoami)
fi

HOME_DIR=$(eval echo ~$REAL_USER)

echo "HOME_DIR is $HOME_DIR"

if grep -q '^HOME_DIR=' $1; then
    sed -i "s|^HOME_DIR=.*|HOME_DIR=$HOME_DIR|" $1
else
    echo "HOME_DIR=$HOME_DIR" >> $1
fi

chmod 666 /var/run/docker.sock
mkdir -p $HOME_DIR/data/mariadb/
mkdir -p $HOME_DIR/data/wordpress/
echo "127.0.0.1	donghyle.42.fr" > /etc/hosts
