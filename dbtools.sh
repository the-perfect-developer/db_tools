#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_FOLDER="$SCRIPT_DIR/scripts"

get_script_description() {
    local script="$1"
    grep -m1 "^# @description" "$script" 2>/dev/null | sed 's/^# @description //'
}

show_help() {
    echo "dbtools - MySQL database dump and restore utilities"
    echo ""
    echo "Usage: ./dbtools.sh <command> [options]"
    echo ""
    echo "Commands:"
    
    for script in "$SCRIPTS_FOLDER"/*.sh; do
        if [ -f "$script" ] && [ -x "$script" ]; then
            local cmd=$(basename "$script" .sh)
            local desc=$(get_script_description "$script")
            [ -z "$desc" ] && desc="No description available"
            printf "  %-12s %s\n" "$cmd" "$desc"
        fi
    done
    
    echo ""
    echo "Run './dbtools.sh <command> --help' for more information on a command."
}

resolve_script() {
    local cmd="$1"
    local script="$SCRIPTS_FOLDER/${cmd}.sh"
    
    if [ -f "$script" ] && [ -x "$script" ]; then
        echo "$script"
        return 0
    fi
    
    return 1
}

if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

case "$1" in
    --help|-h|help)
        show_help
        exit 0
        ;;
    *)
        SCRIPT=$(resolve_script "$1")
        if [ $? -eq 0 ]; then
            shift
            "$SCRIPT" "$@"
        else
            echo "Unknown command: $1"
            echo ""
            show_help
            exit 1
        fi
        ;;
esac
