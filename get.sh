#!/bin/bash
# Remote installer for dbtools
# Usage: curl -fsSL https://raw.githubusercontent.com/the-perfect-developer/db_tools/main/get.sh | sudo bash

set -e

REPO_URL="https://github.com/the-perfect-developer/db_tools.git"
INSTALL_DIR="/opt/dbtools"
BIN_DIR="/usr/local/bin"

# Colors
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
DIM='\033[2m'
NC='\033[0m'

show_banner() {
    echo -e "${CYAN}"
    cat << 'EOF'
     _ _     _              _     
  __| | |__ | |_ ___   ___ | |___ 
 / _` | '_ \| __/ _ \ / _ \| / __|
| (_| | |_) | || (_) | (_) | \__ \
 \__,_|_.__/ \__\___/ \___/|_|___/
EOF
    echo -e "${NC}"
    echo -e "${DIM}MySQL Database Utilities${NC}"
    echo -e "${DIM}By Dilan D Chandrajith - The Perfect Developer${NC}"
    echo ""
}

show_banner
echo "Installing dbtools..."

# Check for git
if ! command -v git &> /dev/null; then
    echo "Error: git is required but not installed"
    exit 1
fi

# Remove existing installation
if [ -d "$INSTALL_DIR" ]; then
    echo "Removing existing installation..."
    rm -rf "$INSTALL_DIR"
fi

# Clone repository
echo "Cloning repository..."
git clone --depth 1 "$REPO_URL" "$INSTALL_DIR" > /dev/null 2>&1

# Make scripts executable
chmod +x "$INSTALL_DIR/dbtools.sh"
chmod +x "$INSTALL_DIR/scripts/"*.sh

# Create symlink
ln -sf "$INSTALL_DIR/dbtools.sh" "$BIN_DIR/dbtools"

echo ""
echo -e "${YELLOW}dbtools installed successfully!${NC}"
echo ""
echo "To get started, run:"
echo "  dbtools --help"
echo ""
echo "To uninstall:"
echo "  sudo rm -rf $INSTALL_DIR $BIN_DIR/dbtools"
