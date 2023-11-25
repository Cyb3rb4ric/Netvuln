#!/bin/bash

# Variables.
SCRIPTHOME=$1
epoc=$(date +%s)
timestamp=$(date +"%FT%T")
network_range=$(ipcalc $(hostname -I) | grep Network | awk '{print $2}')

# Prints header.
function HEADER(){
    echo -e "\n$1"
    echo "------------------------------------------------------------"
}

# Make a scan dir.
function CREATE_CASE(){
    case_path="$SCRIPTHOME"/Scans/"$epoc"
    mkdir -p "$case_path"
}

# Scan local network for online hosts. 
function GET_HOSTS(){
    hosts=$(sudo nmap -sn "$network_range" | grep report | awk '{print $NF}' | sed 's/[(),]//g')
    host_count=$(echo "$hosts" | wc -l)
    HEADER "Local Area Network ($network_range) [$host_count host up]"
    for i in $hosts; do
        echo "[+] $i"
    done
}

# Scans host with nmap using -sV and vulner script.
SCAN_HOST(){
    scan_results=$(sudo nmap -Pn -n --disable-arp-ping "$1" -sV --script=vulners)
    clean_results=$(echo "$scan_results" | grep "open\|CVE")
    if ! [ -z "$clean_results" ]; then
        open_ports_count=$(echo "$clean_results" | grep -c " open ") 
        cve_count=$(echo "$clean_results" | grep "CVE-" | wc -l)
        HEADER "$1 Scan results [ $open_ports_count open ] [ $cve_count vulnerabilities ]"
        echo "$clean_results"
        echo "$clean_results" > "$case_path"/"$1"
    fi
}

# Remove empty case folders.
function CLEAN_CASES(){
    find "$SCRIPTHOME/Scans" -maxdepth 1 -type d -empty -delete
}

echo -e "[*] Starting Netvuln's Scan pluin at $timestamp\n"
CLEAN_CASES
CREATE_CASE
GET_HOSTS
for i in $hosts; do
        SCAN_HOST "$i"
    done 
CLEAN_CASES

