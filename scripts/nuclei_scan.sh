#!/bin/bash

# Helper function for Nuclei vulnerability scanning
run_nuclei_scan() {
  echo "Running Nuclei for vulnerabilities..."
  nuclei -l httpx200.txt -o nuclei.txt -t /root/nuclei-templates/ -rl 50 -H "X-Forwarded-For: 127.0.0.1" -c 4 -mhe 4 -s critical,high,medium
}

# Helper function to run Nuclei on specific vulnerability tags
run_nuclei_specific_tags() {
  local tag="$1"
  echo "Running Nuclei $tag scan..."
  nuclei -l gf/$tag.txt -o nuclei_${tag}.txt -tags "$tag" -rl 30 -H "X-Forwarded-For: 127.0.0.1" -H "X-HackerOne-Research: mohamed53" -c 3 -mhe 4
}

# Main
# Step 4: Nuclei Vulnerability Scan
if [ ! -f "nuclei.txt" ]; then
  run_nuclei_scan
fi

# Step 14: Run Nuclei on specific vulnerability tags
for tag in xss ssrf sqli ssti lfi; do
  if [ ! -f "nuclei_${tag}.txt" ]; then
    run_nuclei_specific_tags "$tag"
  fi
done

echo "Nuclei scanning completed."
