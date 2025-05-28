#!/bin/bash -e
get_release_date() {
    pkg=$1; ver=$2
    curl -s "https://pypi.org/pypi/${pkg}/json" \
    | jq -r --arg V "$ver" '.releases[$V][] | .upload_time_iso_8601' \
    | sort \
    | tail -n1
}
MOL_VER=$(pip --version | awk '{print $2}')
MOL_DATE=$(get_release_date pip "$MOL_VER")
echo "pip $MOL_VER released at $MOL_DATE"
