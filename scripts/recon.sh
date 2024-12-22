#!/bin/bash

# Hack script to automate the process of bug-hunting in an organized manner.

# Define the target domain
TARGET=$1

if [ -z "$TARGET" ]; then
    echo "Please provide a target domain as the first argument (e.g., ./hack.sh example.com)"
    exit 1
fi

# 1. Subdomain Enumeration
echo "[*] Starting subdomain enumeration..."
./subdomainenum.sh $TARGET

# 2. Subdomain Takeover
echo "[*] Starting subdomain takeover check..."
./subdomain_enum.sh 

# 3. HTTPX - Scan live subdomains
echo "[*] Starting HTTPX scan..."
./httpx.sh 

# 4. URL Extraction from Wayback Machine
echo "[*] Starting URL extraction..."
./url_extract.sh 

# 5. Nuclei - Vulnerability scanning
echo "[*] Starting Nuclei vulnerability scan..."
./nuclei_scan.sh 

# 6. JS Analysis (e.g., checking for JavaScript files and analyzing them)
echo "[*] Starting JS analysis..."
./js_analysis.sh

# 7. Fuzzing (Directory and subdomain fuzzing)
echo "[*] Starting fuzzing..."
./fuzz.sh

# 8. Nmap scan (Network mapping)
echo "[*] Starting Nmap scan..."
./nmap.sh 

echo "[*] Bug-hunting automation completed."
