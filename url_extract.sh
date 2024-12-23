#!/bin/bash

# Helper function to fetch URLs from Wayback Machine using waybackurls
fetch_wayback_urls() {
  echo "Gathering URLs from Wayback Machine..."
  cat httpx200.txt | waybackurls > allurls.txt
}

# Helper function to run crawling using Katana
run_katana_crawl() {
  echo "Running Katana for crawling..."
  katana -list httpx200.txt -o katana.txt
}

# Helper function to run crawling using Gospider
run_gospider_crawl() {
  echo "Running Gospider for crawling..."
  gospider -S httpx200.txt -o gospider_output
}

# Helper function to extract URLs from Gospider output
extract_gospider_urls() {
  echo "Extracting URLs from Gospider output..."
  cat gospider_output/* | grep -oP 'http[s]?://\S+' > gospider_urls.txt
}

# Helper function to merge all URL lists
merge_urls() {
  echo "Merging all URLs..."
  cat gospider_urls.txt katana.txt allurls.txt | anew > urls.txt
  rm gospider_urls.txt katana.txt allurls.txt
}

# Helper function to categorize URLs based on file extensions
categorize_urls() {
  echo "Categorizing URLs..."
  cat urls.txt | grep -E "\.js" > js.txt
  cat urls.txt | grep -E "\.php" > php.txt
}

# Helper function to run GF tool for various vulnerabilities
run_gf_vulnerabilities() {
  echo "Running GF for vulnerabilities..."
  mkdir -p gf
  cat urls.txt | gf xss > gf/xss.txt
  cat urls.txt | gf ssrf > gf/ssrf.txt
  cat urls.txt | gf sqli > gf/sqli.txt
  cat urls.txt | gf ssti > gf/ssti.txt
  cat urls.txt | gf lfi > gf/lfi.txt
}

# Step 5: Waybackurls Collection
if [ ! -f "allurls.txt" ]; then
  fetch_wayback_urls
fi

# Step 6: Katana Crawling
if [ ! -f "katana.txt" ]; then
  run_katana_crawl
fi

# Step 7: Gospider Crawling
if [ ! -d "gospider_output" ]; then
  run_gospider_crawl
fi

# Step 8: Extract URLs from Gospider
if [ ! -f "gospider_urls.txt" ]; then
  extract_gospider_urls
fi

# Step 9: Merge All URLs
if [ ! -f "urls.txt" ]; then
  merge_urls
fi
# Step 10: Categorizing URLs
if [ ! -f "js.txt" ] || [ ! -f "php.txt" ]; then
  categorize_urls
fi

# Step 13: Run GF for vulnerabilities
if [ ! -d "gf" ]; then
  run_gf_vulnerabilities
fi

echo "URL extraction and categorization completed."
