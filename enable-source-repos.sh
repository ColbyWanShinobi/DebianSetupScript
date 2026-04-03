#!/usr/bin/env bash

set -e -x

# Enable source repositories
echo "Checking source repositories..."

# Function to enable source repos in a file
enable_sources_in_file() {
    local file="$1"
    if [ -f "$file" ]; then
        # Check if there are any commented deb-src lines
        if grep -q "^# deb-src" "$file"; then
            echo "Enabling source repos in $file"
            sudo sed -i 's/^# deb-src/deb-src/' "$file"
            return 0
        fi
    fi
    return 1
}

# Track if any changes were made
changes_made=0

# Process main sources.list
if [ -f "/etc/apt/sources.list" ]; then
    if enable_sources_in_file "/etc/apt/sources.list"; then
        changes_made=1
    fi
fi

# Process sources.list.d directory
if [ -d "/etc/apt/sources.list.d" ]; then
    for file in /etc/apt/sources.list.d/*.list; do
        if [ -f "$file" ]; then
            if enable_sources_in_file "$file"; then
                changes_made=1
            fi
        fi
    done
fi

# Check if any deb-src lines are active now
if grep -rq "^deb-src" /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null; then
    echo "Source repositories are enabled"
    if [ $changes_made -eq 1 ]; then
        echo "Updating package lists..."
        sudo apt update
    fi
else
    echo "Warning: No source repositories found. You may need to add them manually."
fi
