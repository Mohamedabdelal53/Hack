#!/bin/bash

# Function for directory brute force with Dirsearch
run_dirsearch() {
  echo "Running Dirsearch for directories..."
  dirsearch -l "$(pwd)/httpx.txt" -o dirsearch.txt -i 200 -e conf,config,bak,backup,swp,old,db,sql,asp,aspx,py,php,tar,zip,log,xml,js,json
}

# Main
if [ ! -f "dirsearch.txt" ]; then
  run_dirsearch
fi
