# Use Debian base image (compatible with your VPS environment)
FROM debian:bullseye

# Set the working directory
WORKDIR /app

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    curl \
    git \
    python3 \
    python3-pip \
    golang \
    && apt-get clean

# Set up Go environment variables
ENV GOPATH=/root/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Install tools using `go install`
RUN go install -v github.com/tomnomnom/anew@latest && \
    go install github.com/tomnomnom/assetfinder@latest && \
    GO111MODULE=on go install github.com/jaeles-project/gospider@latest && \
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    CGO_ENABLED=1 go install github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install github.com/Brosck/mantra@latest && \
    go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest && \
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    go install github.com/tomnomnom/waybackurls@latest

# Move tools from ~/go/bin to /usr/local/bin
RUN cp /root/go/bin/* /usr/local/bin/

# Install Nuclei templates
RUN git clone https://github.com/projectdiscovery/nuclei-templates.git /nuclei-templates

# Copy scripts into the container
COPY scripts/ /app/scripts

# Make all scripts executable
RUN chmod +x /app/scripts/*.sh

# Expose default working directory for templates and scripts
WORKDIR /app/scripts

# Default command to keep the container running
CMD ["/bin/bash"]
