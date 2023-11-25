#!/bin/bash

# Variables.
SCRIPTHOME=$1
scan_id=$2
ip_address=$3


#
function OPEN_SCAN(){
    if [ ! -f "$SCRIPTHOME/Scans/$scan_id/$ip_address" ]; then
        echo "[-] Scan not found";
        exit 1
    else
        timestamp=$(date -d @"$scan_id")
        open_ports_count=$(echo "$clean_results" | grep -c " open ") 
        cve_count=$(echo "$clean_results" | grep "CVE-" | wc -l)
        clean_results=$(cat "$SCRIPTHOME/Scans/$scan_id/$ip_address")
    fi
}

# prints header
function HEADER(){
    echo -e "\n$1"
    echo "------------------------------------------------------------------------------------------"
}


OPEN_SCAN
HEADER "$ip_address [ $open_ports_count open ] [ $cve_count vulnerabilities ] [ $timestamp ]"
echo "$clean_results"

