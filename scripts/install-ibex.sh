#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load color definitions
source "$SCRIPT_DIR/../config.sh"

# Get the directory of ibex
IBEX_REPO_DIR="$IBEX_REPO_BASE"
cd $IBEX_REPO_DIR

# Function to print a header
print_header() {
    echo ""
    echo ""
    print_color $CYAN "=============================="
    print_color $CYAN "$1"
    print_color $CYAN "=============================="
    echo ""  # Add extra space after the header for better readability
}

# Function to install a package
install_package() {
    if ! dpkg -l | grep -qw "$1"; then
        echo "Installing $1..."
        sudo apt-get install "$1" -y
    else
        echo "$1 is already installed."
    fi
}

#=== INSTALL VERILATOR ===#

print_header "Installing Verilator"

# Install prerequisites for Verilator
prerequisites=(
    git
    help2man
    perl
    python3
    python3-pip
    make
    g++
    libfl2
    libfl-dev
    zlibc
    zlib1g
    zlib1g-dev
    ccache
    mold
    libgoogle-perftools-dev
    numactl
    perl-doc
    autoconf
    flex
    bison
)

# Install each package
for package in "${prerequisites[@]}"; do
    install_package "$package"
done

cd "$XMINT_REPO_BASE"

# Obtain Verilator Source
if [ ! -d "verilator" ]; then
    git clone https://github.com/verilator/verilator
fi

cd verilator
git pull

# Auto Configure
print_header "Configuring Verilator"
autoconf

# Set VERILATOR_ROOT
export VERILATOR_ROOT="$(pwd)"
print_color $GREEN "VERILATOR_ROOT set to: $VERILATOR_ROOT"

# Compile Verilator
print_header "Compiling Verilator"
./configure
make -j "$(nproc)"

# Test Verilator
print_header "Running Verilator Tests"
make test
sudo make install

# Return to the original directory
cd "$IBEX_REPO_DIR"

#=== INSTALL PYTHON DEPENDENCIES ===#

print_header "Installing Python Dependencies"
pip3 install -U -r python-requirements.txt

#=== INSTALL libelf ===#

print_header "Installing libelf"
echo ""  # Extra space for better readability
install_package libelf-dev

#=== INSTALL srecord ===#

print_header "Installing srecord"
echo ""  # Extra space for better readability
install_package srecord

#=== INSTALL gtkwave ===#

print_header "Installing gtkwave"
echo ""  # Extra space for better readability
install_package gtkwave

#=== INSTALL RISC-V TOOLCHAIN ===#

print_header "Installing RISC-V Compiler Toolchain"
TOOLCHAIN_URL="https://github.com/lowRISC/lowrisc-toolchains/releases/latest"
print_color $YELLOW "Please download the latest RISC-V toolchain from: $TOOLCHAIN_URL"
print_color $YELLOW "Follow the instructions provided in the repository to install it manually."
echo ""  # Extra space for better readability

print_color $BG_GREEN "Installation completed successfully!"
print_color $RED "Make sure to manually install RISC-V Compiler Toolchain as described above"
print_color $YELLOW "It's recommended to add '~/.local/bin' to PATH"
