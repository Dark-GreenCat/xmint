#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load color definitions
source "$SCRIPT_DIR/../config.sh"

# Get the directory of ibex
IBEX_DEMO_SYSTEM_REPO_DIR="$IBEX_DEMO_SYSTEM_REPO_BASE"
cd $IBEX_DEMO_SYSTEM_REPO_DIR

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

#=== INSTALL cmake ===#

print_header "Installing cmake"
echo ""  # Extra space for better readability
install_package cmake

#=== INSTALL PYTHON DEPENDENCIES ===#

print_header "Installing Python Dependencies"
pip3 install -U -r python-requirements.txt

#=== INSTALL screen ===#

print_header "Installing screen"
echo ""  # Extra space for better readability
install_package screen

#=== INSTALL srecord ===#

print_header "Installing srecord"
echo ""  # Extra space for better readability
install_package srecord

#=== INSTALL OpenOCD ===#

print_header "Installing OpenOCD"

# Install prerequisites for OpenOCD
prerequisites=(
    make
    libtool
    pkg-config
    autoconf
    automake
    texinfo
    libjim-dev
    libftdi1
    libusb-1.0-0-dev
)

# Install each package
for package in "${prerequisites[@]}"; do
    install_package "$package"
done

cd "$XMINT_REPO_BASE"

# Obtain OpenOCD Source
if [ ! -d "openocd-code" ]; then
    git clone https://git.code.sf.net/p/openocd/code openocd-code
fi

cd openocd-code

# Build
print_header "Building OpenOCD"
./bootstrap
./configure --enable-armjtagew
make
sudo make install

cp "$SCRIPT_DIR/resources/Makefile.ibex-demo-system" "$XMINT_REPO_BASE/ibex-demo-system/Makefile"

print_color $BG_GREEN "Installation completed successfully!"