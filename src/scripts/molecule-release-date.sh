#!/bin/bash -e
# Enforce error handling and exit on any error

get_release_date() {
    local pkg="$1"
    local ver="$2"

    # Check for missing arguments
    if [ -z "$pkg" ] || [ -z "$ver" ]; then
        echo "Error: Package name and version are required" >&2
        exit 1
    fi

    # Ensure dependencies are available
    command -v curl >/dev/null 2>&1 || { echo "Error: curl is required" >&2; exit 1; }
    command -v jq >/dev/null 2>&1 || { echo "Error: jq is required" >&2; exit 1; }
    command -v sort >/dev/null 2>&1 || { echo "Error: sort is required" >&2; exit 1; }
    command -v tail >/dev/null 2>&1 || { echo "Error: tail is required" >&2; exit 1; }

    # Fetch and process release date
    local json_response
    json_response=$(curl --silent --fail "https://pypi.org/pypi/${pkg}/json" 2>/dev/null)
    if [ -z "$json_response" ]; then
        echo "Error: Failed to fetch data from PyPI for $pkg" >&2
        exit 1
    fi

    local release_date
    release_date=$(echo "$json_response" | jq -r --arg V "$ver" '.releases[$V][] | .upload_time_iso_8601' 2>/dev/null | sort | tail -n1)
    if [ -z "$release_date" ]; then
        echo "Error: No release date found for $pkg version $ver" >&2
        exit 1
    fi

    echo "$release_date"
}

# Check if molecule is installed
if ! command -v molecule >/dev/null 2>&1; then
    echo "Error: molecule is not installed" >&2
    exit 1
fi

# Get molecule version
MOL_VER=$(molecule --version 2>/dev/null | grep -oP 'molecule \K[\d.]+' || true)
if [ -z "$MOL_VER" ]; then
    echo "Error: Could not determine molecule version" >&2
    exit 1
fi

# Get release date
MOL_DATE=$(get_release_date molecule "$MOL_VER")
if [ -z "$MOL_DATE" ]; then
    echo "Error: Could not retrieve release date for molecule $MOL_VER" >&2
    exit 1
fi

# Output result
echo "molecule $MOL_VER released at $MOL_DATE"
