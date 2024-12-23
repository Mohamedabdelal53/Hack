#!/bin/bash

# Function to run Mantra on JavaScript files
run_mantra_on_js() {
  echo "Running Mantra on JavaScript files..."
  cat js.txt | mantra > mantra_results.txt
}
# Helper function to run Nuclei on JavaScript files for vulnerabilities
run_nuclei_js_scan() {
  echo "Running Nuclei JavaScript scan..."
  nuclei -l js.txt -t /root/nuclei-templates/http/exposures/ -rl 30 -c 3 -mhe 4 -H "X-Forwarded-For: 127.0.0.1" > nuclei_js.txt
}


# Main

# Step 11: Run Mantra on JavaScript files
if [ ! -f "mantra_results.txt" ]; then
  run_mantra_on_js
fi
# Step 12: Nuclei Scan for JavaScript Vulnerabilities
if [ ! -f "nuclei_js.txt" ]; then
  run_nuclei_js_scan
fi

echo "JavaScript analysis completed."
