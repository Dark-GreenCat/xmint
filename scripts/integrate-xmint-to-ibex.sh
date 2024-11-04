#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load color definitions
source "$SCRIPT_DIR/../config.sh"

# Function to print messages with a color
print_message() {
    local color="$1"
    shift
    echo -e "$(print_color $color "$@")"
}

# Warning message about the replacement action
print_message $YELLOW "[WARNING] This action will replace 'lowrisc:ibex:ibex_top' with 'Dark-GreenCat:xmint:xmint_top' in the build system."
print_message $YELLOW "This operation is non-revertable unless running the command 'make uninstall-xmint-from-ibex'."
echo -n "Do you want to continue? (Y/N): "

# Read user input
read -r CONTINUE

if [[ "$CONTINUE" != "y" && "$CONTINUE" != "Y" ]]; then
    print_message $RED "Operation cancelled by the user."
    exit 0
fi

# Define the target files and strings
declare -A TARGET_FILES=(
    ["ibex_top_tracing.core"]="ibex/ibex_top_tracing.core"
    ["ibex_tracer.core"]="ibex/ibex_tracer.core"
    ["ibex_top_tracing.sv"]="ibex/rtl/ibex_top_tracing.sv"
    ["verilator_waiver.vlt"]="ibex/lint/verilator_waiver.vlt"
    ["Makefile"]="ibex/Makefile"
    ["ibex_simple_system.sv"]="ibex/examples/simple_system/rtl/ibex_simple_system.sv"
)

SEARCH_STRING="lowrisc:ibex:ibex_top"
REPLACEMENT_STRING="Dark-GreenCat:xmint:xmint_top"
REPLACE_STRING_FILE="$SCRIPT_DIR/xmint_top_instantiate.replace"

# Lint rules for the Verilator waiver file
LINT_RULES=(
    'lint_off -rule UNUSEDPARAM -file "*/rtl/ibex_top_tracing.sv"'
    'lint_off -rule UNUSEDSIGNAL -file "*/rtl/ibex_top_tracing.sv"'
    'lint_off -rule UNDRIVEN -file "*/rtl/ibex_top_tracing.sv"'
)

# Function to replace strings in the first file
patch_ibex_top_tracing_core() {
    local file="$1"
    print_message $CYAN "Patching '$file'..."
    if [[ -f "$file" ]]; then
        sed -i.bak -E "s/\b$SEARCH_STRING\b/$REPLACEMENT_STRING/g" "$file"
        if ! cmp -s "$file" "${file}.bak"; then
            print_message $GREEN "Successfully replaced '$SEARCH_STRING' with '$REPLACEMENT_STRING' in '$file'."
        else
            print_message $YELLOW "No changes made. '$SEARCH_STRING' not found in '$file'."
        fi

        rm -f "${file}.bak"
    else
        print_message $RED "[ERROR] File '$file' not found."
    fi
}

# Function to insert YAML content in the second file
patch_ibex_tracer_core() {
    local file="$1"
    print_message $CYAN "Updating YAML entries in '$file'..."
    if [[ -f "$file" ]]; then
        if grep -q "files_lint_verilator" "$file"; then
            print_message $YELLOW "No updates made. 'files_lint_verilator' entry already exists in '$file'."
        else
            awk '/^filesets:/ {
                print;
                print "  files_lint_verilator:\n    files:\n      - lint/verilator_waiver.vlt: {file_type: vlt}";
                next
            }1' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
            print_message $GREEN "'files_lint_verilator' entry added to '$file'."

            awk '/^  default:/ {
                found=1;
                print;
                next
            }
            found && /^    filesets:/ {
                print;
                print "      - tool_verilator ? (files_lint_verilator)";
                found=0;
                next
            }
            1' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
            print_message $GREEN "'tool_verilator ? (files_lint_verilator)' entry added under 'targets -> default -> filesets' in '$file'."
        fi
    else
        print_message $RED "[ERROR] File '$file' not found."
    fi
}

# Function to replace instance in the SV file
patch_ibex_top_tracing() {
    local file="$1"
    print_message $CYAN "Updating 'ibex_top' instance in '$file'..."
    if [[ -f "$file" ]]; then
        local REPLACEMENT=$(<"$REPLACE_STRING_FILE")
        mv "$file" "$file.bak"
        awk -v replacement="$REPLACEMENT" '
            BEGIN { found = 0 }
            /^  ibex_top #\(/ { found = 1 }
            found && /\);/ {
                print replacement
                found = 0
                next
            }
            !found { print }
        ' "$file.bak" > "$file"

        if ! cmp -s "$file" "${file}.bak"; then
            print_message $GREEN "'ibex_top' instance updated in '$file'."
        else
            print_message $YELLOW "No updates made. 'ibex_top' instance not found in '$file'."
        fi

        rm -f "${file}.bak"
    else
        print_message $RED "[ERROR] File '$file' not found."
    fi
}

# Function to append lines to a file if they do not already exist
patch_verilator_waiver() {
    local file="$1"
    print_message $CYAN "Adding lint rules to '$file'..."

    if [[ -f "$file" ]]; then
        local any_missing=false

        for rule in "${LINT_RULES[@]}"; do
            if ! grep -qF "$rule" "$file"; then
                any_missing=true
                break
            fi
        done

        if $any_missing; then
            echo "" >> "$file"
            for rule in "${LINT_RULES[@]}"; do
                echo "$rule" >> "$file"
            done
            print_message $GREEN "Lint rules successfully added to '$file'."
        else
            print_message $YELLOW "No changes made. All lint rules already present in '$file'."
        fi
    else
        print_message $RED "[ERROR] File '$file' not found."
    fi
}

# Change the fusesoc root
change_fusesoc_root() {
    local file="$1"
    print_message $CYAN "Updating cores-root path in '$file'..."
    sed -i 's/--cores-root=\.\([^\.]\|$\)/--cores-root=.. /g' "$file"
    print_message $GREEN "Cores-root path updated in '$file'."
}

# Patch the simple system file
patch_ibex_simple_system() {
    local file="$1"
    print_message $CYAN "Updating return statements in '$file'..."
    sed -i -E '/^[[:space:]]*return/ {s/^([[:space:]]*)return.*/\1return 0;/}' "$file"
    print_message $GREEN "Return statements patched in '$file'."
}

# Perform replacements and insertions
print_message $CYAN "Starting the patch process..."

patch_ibex_top_tracing_core "${TARGET_FILES["ibex_top_tracing.core"]}"
patch_ibex_tracer_core "${TARGET_FILES["ibex_tracer.core"]}"
patch_ibex_top_tracing "${TARGET_FILES["ibex_top_tracing.sv"]}"
patch_verilator_waiver "${TARGET_FILES["verilator_waiver.vlt"]}"
change_fusesoc_root "${TARGET_FILES["Makefile"]}"
patch_ibex_simple_system "${TARGET_FILES["ibex_simple_system.sv"]}"

print_message $BG_GREEN "Patch process completed successfully!"
