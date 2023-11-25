#!/bin/bash

#########################################################
# Netvuln - Network Vulnerability Assessment Framework  #
#########################################################

# Description:
# Netvuln is a comprehensive framework designed for automated scanning of local area
# networks to identify active hosts, detect open ports, and uncover vulnerabilities (CVEs)
# on the identified hosts. The framework also includes tools for automating brute force attacks
# on login services such as SSH, SMB, FTP, and Telnet. Additionally, Netvuln provides
# functionality to create custom wordlists for brute force attacks and offers tools for managing
# and reviewing past scan results.

# Prerequisites:
# - Ensure that the script is executed with root privileges (sudo) due to its nature.
# - Run the "install.sh" script as sudo to set up the framework:
#   ```bash
#   sudo bash install.sh
#   ```

# Usage:
# 1. Run the script with root privileges and provide one of the available options.
#    Example: sudo netvuln scan
# 2. The framework will execute the chosen operation, such as network scanning,
#    vulnerability assessment, or brute force attack.
# 3. Follow the on-screen instructions to provide additional information as needed.

# Note:
# - Use this tool responsibly and in compliance with legal and ethical guidelines.
# - Ensure that you have appropriate permissions before scanning or probing any network.
# - Netvuln is a powerful tool that can have significant implications, so exercise caution.

# Author: Cyb3rb4ric
# Email: magencyber@proton.me

#######################################################################


# Checks if the script is executed with sudo privileges and exits if not.
function CHECK_SUDO(){
    if [ "$EUID" -ne 0 ]
        then echo "Please run with sudo."
        exit 1
    fi
}

# Prints a help menu when no arguments are provided.
function HELP(){
    WELCOME
    echo -e "[*] NetVuln version 1.0.0\n"
    echo "Usage: netvuln [option]"
    echo "options:"
    echo -e "  scan  :Scan LAN for Vulnerabilities."
    echo -e "  list  :List all past scans."
    echo -e "  remove <scan_id>  :Remove Scan from system."
    echo -e "  show <scan_id>  :Show the results of past scan."
    echo -e "  wordlist <min-len> <max-len> <characters> <output-name> :Creates a wordlist and save it to file."
    echo -e "  brute <ip_address> <port> <service> <user_wl> <pass_wl>  :Bruteforce a login service."
    exit 1
}

# GET the working directory of the script to the directory where the script is located.
function GET_SCRIPT_HOME(){
    script_path=$(readlink -f "$0") 
    SCRIPTHOME=$( cd -P "$(dirname "$script_path")" || exit 1 ; pwd -P )
}

# Prints ASCII art.
function WELCOME(){
    cat "$SCRIPTHOME"/scripts/welcome.txt
    echo " "
}

# Function to manage various sub-scripts based on user input.
function RUN_SCRIPTS(){
    case $1 in
        scan)
            source "$SCRIPTHOME"/scripts/scan.sh "$SCRIPTHOME";;
        remove)
            rm -r $SCRIPTHOME/Scans/$2 2>/dev/null|| echo "[-] Scan does not exist!";;
        wordlist)
            source "$SCRIPTHOME"/scripts/wordlist.sh "$SCRIPTHOME" $2 $3 $4 $5;;
        brute)
            source "$SCRIPTHOME"/scripts/brute.sh "$SCRIPTHOME" $2 $3 $4 $5 $6;;
        show)
            source "$SCRIPTHOME"/scripts/show.sh "$SCRIPTHOME" $2 $3;;
        list)
            source "$SCRIPTHOME"/scripts/list.sh "$SCRIPTHOME";;
        *)
            HELP;;
    esac
}

CHECK_SUDO
GET_SCRIPT_HOME
RUN_SCRIPTS $1 $2 $3 $4 $5 $6
exit 0