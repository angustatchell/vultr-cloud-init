#!/bin/sh

# Check for the existence of necessary commands
if command -v uptime > /dev/null && command -v free > /dev/null && command -v df > /dev/null; then
    echo "\nSystem Load: $(uptime)\n\nFree Memory: $(free -h)\n\nDisk Usage: $(df -h)\n"
else
    echo "Required commands not available."
fi
