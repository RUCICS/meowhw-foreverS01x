#!/usr/bin/env sh

set -e

# Detect the system
OS="$(uname -s)"
ARCH="$(uname -m)"

# Normalize OS name
case "$OS" in
    Linux) OS=unknown-linux-gnu ;;
    Darwin) OS=apple-darwin ;;
    *) echo "Unsupported OS: $OS"; exit 1 ;;
esac

# Normalize architecture
case "$ARCH" in
    x86_64) ARCH=x86_64 ;;
    aarch64 | arm64) ARCH=aarch64 ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Construct the filename
FILENAME="uv-${ARCH}-${OS}.tar.gz"
URL="https://github.com/astral-sh/uv/releases/latest/download/${FILENAME}"

# Download and extract
echo "Downloading $URL..."
curl -LO "$URL"

echo "Extracting..."
tar -xzf "$FILENAME"

# Move binary to /usr/local/bin (requires sudo)
echo "Installing to /usr/local/bin (may require sudo)..."
sudo mv uv /usr/local/bin/

# Clean up
rm "$FILENAME"

echo "✅ uv installed successfully. Try running: uv --help"
