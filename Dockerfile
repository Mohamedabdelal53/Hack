# Base image
FROM debian:latest

# Set working directory
WORKDIR /hack

# Copy all scripts into the container
COPY . /hack

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    curl git wget python3 python3-pip nmap dirsearch && \
    pip install --no-cache-dir httpx subfinder assetfinder anew gf nuclei gospider katana && \
    chmod +x *.sh

# Default command to keep the container running
CMD ["/bin/bash"]
