#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load color definitions
source "$SCRIPT_DIR/../config.sh"

# Get the directory of riscv-compliance and ibex
RISCV_COMPLIANCE_REPO_DIR="$RISCV_COMPLIANCE_REPO_BASE"

# Create and configure the config-riscv-compliance.sh file
CONFIG_FILE="config-riscv-compliance.sh"

# Check if the config file already exists and remove it
if [ -e "$CONFIG_FILE" ]; then
    rm "$CONFIG_FILE"
fi

# Create a new config file and make it executable
touch "$CONFIG_FILE"
chmod +x "$CONFIG_FILE"

# Write configuration settings to the file
{
    echo "export RISCV_COMPLIANCE_REPO_BASE=$RISCV_COMPLIANCE_REPO_DIR"
    echo "export TARGET_SIM=$Vibex_riscv_compliance"
    echo "export RISCV_PREFIX=riscv32-unknown-elf-"
    echo "export RISCV_TARGET=ibex"
    echo "export RISCV_DEVICE=I"
} >> "$CONFIG_FILE"
