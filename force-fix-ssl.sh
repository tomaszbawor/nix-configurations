#!/bin/bash

echo "Force fixing SSL certificates..."

# Stop nix-daemon
sudo launchctl stop org.nixos.nix-daemon

# Clear Nix's HTTP cache
rm -rf ~/.cache/nix/

# Download and install certificates from brew's ca-certificates
if command -v brew &>/dev/null; then
    echo "Using brew's certificates..."
    BREW_CERT=$(brew --prefix)/etc/ca-certificates/cert.pem
    if [ -f "$BREW_CERT" ]; then
        sudo cp "$BREW_CERT" /etc/nix/ca_cert.pem
    else
        echo "Installing ca-certificates via brew..."
        brew install ca-certificates
        sudo cp $(brew --prefix)/etc/ca-certificates/cert.pem /etc/nix/ca_cert.pem
    fi
else
    echo "Using curl's certificate bundle..."
    curl -k -o /tmp/cacert.pem https://curl.se/ca/cacert.pem
    sudo cp /tmp/cacert.pem /etc/nix/ca_cert.pem
fi

# Set permissions
sudo chmod 644 /etc/nix/ca_cert.pem

# Start nix-daemon
sudo launchctl start org.nixos.nix-daemon

# Wait for daemon to start
sleep 3

# Test connection
echo "Testing connection..."
NIX_SSL_CERT_FILE=/etc/nix/ca_cert.pem curl -I https://cache.nixos.org

echo "Done. Setting up environment..."

# Export SSL certificate for current session
export NIX_SSL_CERT_FILE=/etc/nix/ca_cert.pem

echo ""
echo "SSL certificates have been fixed!"
echo ""
echo "To use darwin-rebuild, run:"
echo "  sudo NIX_SSL_CERT_FILE=/etc/nix/ca_cert.pem darwin-rebuild switch --flake .#work"
echo ""
echo "Or add this to your shell profile:"
echo "  export NIX_SSL_CERT_FILE=/etc/nix/ca_cert.pem"
