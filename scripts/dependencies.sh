#!/bin/bash

LOCAL_REQUIREMENTS=("ipcalc" "nmap" "crunch" "medusa")

# Check/Install local host requirements.
function INSTALL_LOCAL_DEPENDENCIES(){
    deinstall=$(dpkg --get-selections | grep deinstall | cut -f1)
    sudo dpkg --purge "$deinstall" >/dev/null 2>&1
    for package_name in "${LOCAL_REQUIREMENTS[@]}"; do
        dpkg -s "$package_name" >/dev/null 2>&1 || 
        (echo -e "[*] installing $package_name..." &&
        sudo apt-get install "$package_name" -y >/dev/null 2>&1)
    done
}

INSTALL_LOCAL_DEPENDENCIES
