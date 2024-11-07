#!/bin/bash

# Get the directory of the script
export XMINT_REPO_BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load color definitions
source "$XMINT_REPO_BASE/scripts/color.sh"

# Get the variables for ibex
export IBEX_REPO_BASE="$XMINT_REPO_BASE/ibex"
export Vibex_simple_system="$IBEX_REPO_BASE/build/lowrisc_ibex_ibex_simple_system_0/sim-verilator/Vibex_simple_system"
export Vibex_riscv_compliance="$IBEX_REPO_BASE/build/lowrisc_ibex_ibex_riscv_compliance_0.1/sim-verilator/Vibex_riscv_compliance"
export Vtb_cs_registers="$IBEX_REPO_BASE/build/lowrisc_ibex_tb_cs_registers_0/sim-verilator/Vtb_cs_registers"

# Get the variables for riscv-compliance
export RISCV_COMPLIANCE_REPO_BASE="$XMINT_REPO_BASE/riscv-compliance"

# Get the variables for ibex-demo-system
export IBEX_DEMO_SYSTEM_REPO_BASE="$XMINT_REPO_BASE/ibex-demo-system"
export Vibex_demo_system="$IBEX_DEMO_SYSTEM_REPO_BASE/build/lowrisc_ibex_demo_system_0/sim-verilator/Vtop_verilator"
