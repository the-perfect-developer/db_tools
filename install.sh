#!/bin/bash
# @description Install dbtools to system PATH

INSTALL_DIR="/usr/local/bin"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXECUTABLE="dbtools"

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

show_help() {
    show_banner
    echo "Install dbtools to system PATH"
    echo ""
    echo "Usage: ./install.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --install     Install dbtools (creates symlink in $INSTALL_DIR)"
    echo "  --uninstall   Remove dbtools from $INSTALL_DIR"
    echo "  --help        Show this help message"
    echo ""
    echo "After installation, run 'dbtools --help' to see available commands."
}

install() {
    show_banner
    echo "Installing dbtools..."
    
    if [ ! -f "$SCRIPT_DIR/dbtools.sh" ]; then
        echo "Error: dbtools.sh not found in $SCRIPT_DIR"
        exit 1
    fi

    # Check if we have write permission
    if [ ! -w "$INSTALL_DIR" ]; then
        echo "Error: No write permission to $INSTALL_DIR"
        echo "Run with sudo: sudo ./install.sh --install"
        exit 1
    fi

    # Remove existing symlink if present
    if [ -L "$INSTALL_DIR/$EXECUTABLE" ]; then
        rm "$INSTALL_DIR/$EXECUTABLE"
    fi

    # Create symlink
    ln -s "$SCRIPT_DIR/dbtools.sh" "$INSTALL_DIR/$EXECUTABLE"
    
    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${YELLOW}Installed successfully!${NC}"
        echo ""
        echo "To get started, run:"
        echo "  dbtools --help"
    else
        echo "Error: Failed to create symlink"
        exit 1
    fi
}

uninstall() {
    show_banner
    echo "Uninstalling dbtools..."
    
    if [ ! -L "$INSTALL_DIR/$EXECUTABLE" ]; then
        echo "dbtools is not installed in $INSTALL_DIR"
        exit 1
    fi

    # Check if we have write permission
    if [ ! -w "$INSTALL_DIR" ]; then
        echo "Error: No write permission to $INSTALL_DIR"
        echo "Run with sudo: sudo ./install.sh --uninstall"
        exit 1
    fi

    rm "$INSTALL_DIR/$EXECUTABLE"
    
    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${YELLOW}Uninstalled successfully!${NC}"
    else
        echo "Error: Failed to remove symlink"
        exit 1
    fi
}

# Main
case "$1" in
    --install)
        install
        ;;
    --uninstall)
        uninstall
        ;;
    --help|"")
        show_help
        ;;
    *)
        echo "Unknown option: $1"
        show_help
        exit 1
        ;;
esac
