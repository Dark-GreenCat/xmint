#!/bin/bash

# Get the directory of the script
XMINT_REPO_BASE="$(cd "$(dirname "$0")" && pwd)"

# Change to that directory
cd "$XMINT_REPO_BASE"

# Load color definitions
source "$XMINT_REPO_BASE/scripts/color.sh"

# Get the directory of ibex
IBEX_REPO_BASE="$XMINT_REPO_BASE/ibex"
Vibex_simple_system="$IBEX_REPO_BASE/build/lowrisc_ibex_ibex_simple_system_0/sim-verilator/Vibex_simple_system"
Vibex_riscv_compliance="$IBEX_REPO_BASE/build/lowrisc_ibex_ibex_riscv_compliance_0.1/sim-verilator/Vibex_riscv_compliance"
Vtb_cs_registers="$IBEX_REPO_BASE/build/lowrisc_ibex_tb_cs_registers_0/sim-verilator/Vtb_cs_registers"
