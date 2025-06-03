#!/bin/bash

# darwin-rebuild wrapper with SSL certificate fix
# This script ensures SSL certificates are properly configured before running darwin-rebuild

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Running darwin-rebuild with SSL certificate fix...${NC}"

# Ensure SSL certificate is set
export NIX_SSL_CERT_FILE=/etc/nix/ca_cert.pem

# Check if certificate file exists
if [ ! -f "$NIX_SSL_CERT_FILE" ]; then
    echo -e "${YELLOW}SSL certificate not found. Running fix script...${NC}"
    if [ -f "$(dirname "$0")/force-fix-ssl.sh" ]; then
        sudo bash "$(dirname "$0")/force-fix-ssl.sh"
    else
        echo "Error: force-fix-ssl.sh not found!"
        exit 1
    fi
fi

# Pass all arguments to darwin-rebuild with SSL cert environment variable
echo -e "${GREEN}Running: sudo NIX_SSL_CERT_FILE=$NIX_SSL_CERT_FILE darwin-rebuild $@${NC}"
sudo NIX_SSL_CERT_FILE=$NIX_SSL_CERT_FILE darwin-rebuild "$@"