#!/bin/bash

# Helper function to process subdomain enumeration
enumerate_subdomains() {
  local domain_input="$1"

  if [[ -f "$domain_input" ]]; then
    # If the input is a file
    echo "Running subdomain enumeration for domains in file: $domain_input..."
    subfinder -dL "$domain_input" -all --recursive -o subdomains_tmp.txt
    cat "$domain_input" | assetfinder -subs-only >> subdomains_tmp.txt
    cat subdomains_tmp.txt | anew > subdomains
    rm subdomains_tmp.txt
  else
    # If the input is a single domain
    echo "Running subdomain enumeration for single domain: $domain_input..."
    subfinder -d "$domain_input" -all --recursive -o subdomains_tmp.txt
    echo "$domain_input" | assetfinder -subs-only >> subdomains_tmp.txt
    cat subdomains_tmp.txt | anew > subdomains
    rm subdomains_tmp.txt
  fi
}

# Main script execution starts here
TARGET=$1

if [[ -z "$TARGET" ]]; then
  echo "Usage: $0 <domain_or_file>"
  exit 1
fi

if [ ! -f "subdomains" ]; then
  enumerate_subdomains "$TARGET"
fi
