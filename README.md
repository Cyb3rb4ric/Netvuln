# Netvuln - Network Vulnerability Assessment Framework

## Description

Netvuln is a comprehensive framework designed for automated scanning of local area networks to identify active hosts, detect open ports, and uncover vulnerabilities (CVEs) on the identified hosts. The framework also includes tools for automating brute force attacks on login services such as SSH, SMB, FTP, and Telnet. Additionally, Netvuln provides functionality to create custom wordlists for brute force attacks and offers tools for managing and reviewing past scan results.

## Features

- Automatic network scanning to identify live hosts.
- Port scanning on identified hosts to discover open ports.
- Vulnerability scanning to detect and report known vulnerabilities (CVEs).
- Automated brute force attack tools for supported login services.
- Wordlist generation tool for customizing brute force attacks.
- Scan management tools for organizing and viewing historical scan results.

## Installation

To install Netvuln, follow these steps:

1. Download or clone the Netvuln repository.
2. Navigate to the Netvuln directory.
3. Run the following command as sudo to install the framework:
```bash
   sudo bash install.sh
```

## Usage

1. Run the framework with root privileges and provide desired options:
```bash
    sudo netvuln <option>
```
Replace `<option>` with one of the available framework features or commands.

2. Follow the on-screen instructions to proceed with network scanning, vulnerability assessment, brute force attacks, wordlist creation, and more.

## Options

- `scan`: Scan LAN for vulnerabilities.
- `list`: List all past scans.
- `remove` `<scan_id>`: Remove scan from the system.
- `show` `<scan_id>`: Show the results of a past scan.
- `wordlist` `<min-len>` `<max-len>` `<characters>` `<output-name>`: Create a wordlist and save it to a file.
- `brute` `<ip_address>` `<port>` `<service>` `<user_wl>` `<pass_wl>`: Perform a brute force attack on a login service.

## Note

- Use Netvuln responsibly and in compliance with legal and ethical guidelines.
- Ensure that you have appropriate permissions before scanning or probing any network.
- Netvuln is a powerful tool that can have significant implications, so exercise caution.

## Author

Author: Cyb3rb4ric
Email: magencyber@proton.me
Penetration Testing school project

---
