#!/bin/bash

# Function for Nmap scanning
run_nmap_scan() {
  echo "Running Nmap scan on subdomains..."
  nmap -iL subdomains -oN nmap_results.txt
}

# Step 16: Nmap Scan on Subdomains
if [ ! -f "scan.txt" ]; then
  run_nmap_scan
  echo "Nmap scan completed."
fi