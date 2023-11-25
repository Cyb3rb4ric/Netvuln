#!/bin/bash

# Checks if the script is executed with sudo privileges and exits if not.
if [ "$EUID" -ne 0 ]
        then echo "Please run with sudo."
        exit 1
fi

# Changes the working directory of the script to the directory where the script is located.
SCRIPTHOME=$( cd "$(dirname "$0")" || exit 1 ; pwd -P )

# Executes the local dependencies script (dependencies.sh) using the 'source' command.
source "$SCRIPTHOME/scripts/dependencies.sh"

# Create symbolic link in bin folder for making 'netvuln' a command on the system.
if ! [ -f "/usr/local/bin/netvuln" ]; then
    ln -s "$SCRIPTHOME"/netvuln.sh /usr/local/bin/netvuln
fi

echo "[*] Done!"