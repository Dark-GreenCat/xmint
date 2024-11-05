#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load color definitions
source "$SCRIPT_DIR/../config.sh"

# Define the target files and their associated parameters
declare -A TARGET_FILES=(
    ["patch_ibex_demo_system"]="ibex-demo-system/rtl/system/ibex_demo_system.sv"
)

# Function to print messages with a specified color
print_message() {
    local color="$1"
    shift
    echo -e "$(print_color "$color" "$@")"
}

# Warning message about the replacement action
print_message "$YELLOW" "[WARNING] This action will integrate both Ibex and XMint to Ibex Demo System"
echo -n "Do you want to continue? (Y/N): "

# Read user input
read -r CONTINUE

if [[ "$CONTINUE" != "y" && "$CONTINUE" != "Y" ]]; then
    print_message "$RED" "Operation cancelled by the user."
    exit 0
fi

remove_outdated_ibex() {
    rm -rf "ibex-demo-system/vendor/lowrisc_ibex"
}

remove_outdated_ip() {
    cp "ibex-demo-system/vendor/lowrisc_ip/ip/prim/rtl/prim_sync_reqack.sv" "$SCRIPT_DIR"
    rm -rf "ibex-demo-system/vendor/lowrisc_ip/ip"
    mkdir "ibex-demo-system/vendor/lowrisc_ip/ip"
    mkdir "ibex-demo-system/vendor/lowrisc_ip/ip/prim"
    mkdir "ibex-demo-system/vendor/lowrisc_ip/ip/prim/rtl"
    mv "$SCRIPT_DIR/prim_sync_reqack.sv" "ibex-demo-system/vendor/lowrisc_ip/ip/prim/rtl"
}

# Function to update return statements in the specified file
patch_ibex_demo_system() {
    local file="$1"

    print_message "$CYAN" "Updating return statements in '$file'..."
    if sed -i -E '/^[[:space:]]*return/ {s/^([[:space:]]*)return.*/\1return 0;/}' "$file"; then
        print_message "$GREEN" "Return statements patched in '$file'."
    else
        print_message "$RED" "Error: Failed to update return statements in '$file'."
    fi
}

# Execute the patching functions using parameters from the TARGET_FILES array
patch_ibex_demo_system ${TARGET_FILES["patch_ibex_demo_system"]}
remove_outdated_ibex
remove_outdated_ip

print_message "$BG_GREEN" "Patch process completed successfully!"