#!/bin/bash

# Check if number of arguments is not 1
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# Get the real user's home directory even if the script is run with sudo
if [ "$SUDO_USER" ]; then
    REAL_USER=$SUDO_USER
else
    REAL_USER=$(whoami)
fi

HOME_DIR=$(eval echo ~$REAL_USER)

echo "HOME_DIR is $HOME_DIR"

# Check if the file has a line starting with "HOME_DIR="
if grep -q '^HOME_DIR=' $1; then
    # If the line exists, replace it
    sed -i "s|^HOME_DIR=.*|HOME_DIR=$HOME_DIR|" $1
else
    # If the line does not exist, append it to the end of the file
    echo "HOME_DIR=$HOME_DIR" >> $1
fi

chmod 666 /var/run/docker.sock
mkdir -p $HOME_DIR/data/mariadb/
mkdir -p $HOME_DIR/data/wordpress/
echo "127.0.0.1	donghyle.42.fr" > /etc/hosts
