
# Helper function to run Subzy vulnerability scan
run_subzy_scan() {
  echo "Running Subzy for vulnerabilities..."
  subzy run --targets subdomains --vuln --hide_fails > subzy_results.txt
}

# Step 2: Subzy Vulnerability Scan
if [ ! -f "subzy_results.txt" ]; then
  run_subzy_scan
fi
