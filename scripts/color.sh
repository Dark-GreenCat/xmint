#!/bin/bash

# Define color codes
RESET="\e[0m"
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"

# Background colors
BG_BLACK="\e[40m"
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_MAGENTA="\e[45m"
BG_CYAN="\e[46m"
BG_WHITE="\e[47m"

# Text styles
BOLD="\e[1m"
UNDERLINE="\e[4m"

# Function to print with color
print_color() {
    local color="$1"
    shift
    echo -e "${color}$@${RESET}"
}

# Usage examples
# Uncomment the following lines to test the colors
# print_color $RED "This is red text"
# print_color $GREEN "This is green text"
# print_color $YELLOW "This is yellow text"