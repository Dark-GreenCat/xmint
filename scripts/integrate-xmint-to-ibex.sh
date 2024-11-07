#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load color definitions
source "$SCRIPT_DIR/../config.sh"

# Define the target files and their associated parameters
declare -A TARGET_FILES=(
    ["insert_dependency"]="ibex/ibex_top.core Dark-GreenCat:xmint:xmint_top"
    ["patch_ibex_top_sv"]="$SCRIPT_DIR/resources/ibex_top.sv.patch ibex/rtl/ibex_top.sv"
    ["patch_ibex_simple_system"]="ibex/examples/simple_system/rtl/ibex_simple_system.sv"
    ["change_fusesoc_root"]="ibex/Makefile"
)

# Function to print messages with a specified color
print_message() {
    local color="$1"
    shift
    echo -e "$(print_color "$color" "$@")"
}

# Warning message about the replacement action
print_message "$YELLOW" "[WARNING] This action will replace 'lowrisc:ibex:ibex_top' with 'Dark-GreenCat:xmint:xmint_top' in the build system."
print_message "$YELLOW" "This operation is non-reversible unless running the command 'make uninstall-xmint-from-ibex'."
echo -n "Do you want to continue? (Y/N): "

# Read user input
read -r CONTINUE

if [[ "$CONTINUE" != "y" && "$CONTINUE" != "Y" ]]; then
    print_message "$RED" "Operation cancelled by the user."
    exit 0
fi

# Function to insert a dependency into the specified file
insert_dependency() {
    local file="$1"
    local dependency="$2"

    print_message "$CYAN" "Checking for existing dependency in '$file'..."

    if grep -qF "$dependency" "$file"; then
        print_message "$YELLOW" "Dependency already exists in $file. No changes made."
        return
    fi

    print_message "$GREEN" "Inserting dependency into '$file'..."
    if sed -i "/^\s*files_rtl:/,/^\s*files:/{ /^\s*depend:/a\\
      - $dependency
    }" "$file"; then
        print_message "$GREEN" "Dependency added successfully to $file."
    else
        print_message "$RED" "Error: Failed to insert dependency into $file."
    fi
}

# Function to patch a specified source file by copying it to the target directory
patch_ibex_top_sv() {
    local source_file="$1"
    local target_dir="$2"

    print_message "$CYAN" "Patching $source_file..."
    if cp "$source_file" "$target_dir"; then
        print_message "$GREEN" "Successfully patched $source_file."
    else
        print_message "$RED" "Error: Failed to patch $source_file."
    fi
}

# Function to update return statements in the specified file
patch_ibex_simple_system() {
    local file="$1"

    print_message "$CYAN" "Updating return statements in '$file'..."
    if sed -i -E '/^[[:space:]]*return/ {s/^([[:space:]]*)return.*/\1return 0;/}' "$file"; then
        print_message "$GREEN" "Return statements patched in '$file'."
    else
        print_message "$RED" "Error: Failed to update return statements in '$file'."
    fi
}

# Change the fusesoc root
change_fusesoc_root() {
    local makefile="$1"
    local search_string="fusesoc"
    local cores_root=" --cores-root=../xmint"

    print_message $CYAN "Updating cores-root path in '$makefile'..."

    if [[ ! -f "$makefile" ]]; then
        print_message $RED "Makefile does not exist: $makefile"
        return 1
    fi

    # Check if the search string exists and if the cores-root is already present
    if grep -q "$search_string" "$makefile"; then
        if ! grep -q "$cores_root" "$makefile"; then
            # Escape special characters in the search string and cores_root
            local escaped_search_string=$(printf '%s\n' "$search_string" | sed 's/[\/&]/\\&/g')
            local escaped_cores_root=$(printf '%s\n' "$cores_root" | sed 's/[\/&]/\\&/g')

            # Insert the cores-root option immediately after "fusesoc"
            sed -i "s/$escaped_search_string/$escaped_search_string$escaped_cores_root/" "$makefile"
            print_message $GREEN "Added '$cores_root' after '$search_string' in $makefile"
        else
            print_message $YELLOW "'$cores_root' already exists after '$search_string' in $makefile. No changes made."
        fi
    else
        print_message $RED "'$search_string' not found in $makefile"
    fi
}

# Execute the patching functions using parameters from the TARGET_FILES array
insert_dependency ${TARGET_FILES["insert_dependency"]}
patch_ibex_top_sv ${TARGET_FILES["patch_ibex_top_sv"]}
patch_ibex_simple_system ${TARGET_FILES["patch_ibex_simple_system"]}
change_fusesoc_root ${TARGET_FILES["change_fusesoc_root"]}

print_message "$BG_GREEN" "Patch process completed successfully!"
