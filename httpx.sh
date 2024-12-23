# Helper function to check HTTP status codes using httpx
check_http_status() {
  echo "Checking HTTP status codes..."
  cat subdomains | httpx -o httpx.txt
  cat httpx.txt | httpx -mc 200 -o httpx200.txt
  echo "Sending Alive Subdomains To Proxy"
  cat httpx200.txt | httpx -http-proxy http://138.68.69.33:8080
}
# Step 3: HTTPx Status Check
if [ ! -f "httpx200.txt" ]; then
  check_http_status
fi
