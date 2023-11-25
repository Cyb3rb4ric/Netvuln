#!/bin/bash

# Variables.
SCRIPTHOME=$1
case_list=$(ls "$SCRIPTHOME/Scans")
scan_count=$(echo $case_list | wc -w)

# prints header
function HEADER(){
    echo -e "\n$1"
    echo "------------------------------------------------------------"
}

# Function to check for login services in a log file and display them categorically.
function CHECK_LOGING_BRUTE(){
    IFS=$'\n'
    echo -e "\t\tlogin services:"
    ssh_service=$(cat "$1" | grep " ssh " | awk '{print $3,$1}')
    if [ ! -z "$ssh_service" ]; then
        for s in $ssh_service; do
            echo -e "\t\t\t$s"
        done
    fi
    telnet_service=$(cat "$1" | grep " telnet " | awk '{print $3,$1}')
    if [ ! -z "$telnet_service" ]; then
        for s in $telnet_service; do
            echo -e "\t\t\t$s"
        done
    fi
    ftp_service=$(cat "$1" | grep " ftp " | awk '{print $3,$1}')
    if [ ! -z "$ftp_service" ]; then
        for s in $ftp_service; do
            echo -e "\t\t\t$s"
        done
    fi
    smb_service=$(cat "$1" | grep " Samba " | awk '{print $4,$1}')
    if [ ! -z "$smb_service" ]; then
        for s in $smb_service; do
            echo -e "\t\t\t$s"
        done
    fi
}

# Function to print details of scanned IP addresses along with their login services from scan results.
function PRINT_SCANS(){
    for d in $case_list; do
    echo "[+] $d ($(date -d @$d))"
        ip_address=$(ls "$SCRIPTHOME/Scans/$d")
        for f in $ip_address; do
            echo -e "\tip address: $f"
            CHECK_LOGING_BRUTE "$SCRIPTHOME/Scans/$d/$f"
        done
    done
}


if [ -z "$case_list" ]; then
        echo "[-] no Scans found, please run 'sudo netvuln scan' first."
        exit 1
fi
HEADER "Scans by id [ $scan_count found ]"
PRINT_SCANS