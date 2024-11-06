#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load color definitions
source "$SCRIPT_DIR/../config.sh"

# Define the target files and their associated parameters
declare -A TARGET_FILES=(
    ["patch_ibex_demo_system"]="ibex-demo-system/rtl/system/ibex_demo_system.sv"
    ["patch_ibex_top_sv"]="$SCRIPT_DIR/resources/ibex_top.sv.ibex-demo-system ibex-demo-system/vendor/lowrisc_ibex/rtl/ibex_top.sv"
    ["create_makefile"]="$SCRIPT_DIR/resources/Makefile.ibex-demo-system ibex-demo-system/Makefile"
    ["insert_dependency"]="ibex-demo-system/vendor/lowrisc_ibex/ibex_top.core Dark-GreenCat:xmint:xmint_top"
    ["insert_lint_rule"]="$SCRIPT_DIR/resources/verilator_waiver.vlt.ibex-demo-system ibex-demo-system/vendor/lowrisc_ibex/lint/verilator_waiver.vlt"
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

# Function to patch a specified source file by copying it to the target directory
patch_ibex_top_sv() {
    local source_file="$1"
    local target_dir="$2"

    print_message "$CYAN" "Patching $target_dir..."
    if cp "$source_file" "$target_dir"; then
        print_message "$GREEN" "Successfully patched $target_dir."
    else
        print_message "$RED" "Error: Failed to patch $target_dir."
    fi
}

create_makefile() {
    local source_file="$1"
    local target_dir="$2"

    print_message "$CYAN" "Generating $target_dir..."
    if cp "$source_file" "$target_dir"; then
        print_message "$GREEN" "Successfully generated $target_dir."
    else
        print_message "$RED" "Error: Failed to generate $target_dir."
    fi
}

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

insert_lint_rule() {
    local source_file="$1"
    local target_file="$2"

    print_message "$CYAN" "Checking for existing lint rules in '$target_file'..."

    if [[ ! -f "$source_file" ]]; then
        echo "Source file does not exist: $source_file"
        return 1
    fi

    if [[ ! -f "$target_file" ]]; then
        echo "Target file does not exist: $target_file"
        return 1
    fi

    if grep -q -F -x -f "$source_file" "$target_file"; then
        print_message "$YELLOW" "Lint rules already exists in $target_file. No changes made."
        return
    else
        echo "" >> "$target_file"
        cat "$source_file" >> "$target_file"
        echo "" >> "$target_file"
        print_message "$GREEN" "Lint rules added successfully to "$target_file"."
    fi
}

# Execute the patching functions using parameters from the TARGET_FILES array
patch_ibex_demo_system ${TARGET_FILES["patch_ibex_demo_system"]}
patch_ibex_top_sv ${TARGET_FILES["patch_ibex_top_sv"]}
create_makefile ${TARGET_FILES["create_makefile"]}
insert_dependency ${TARGET_FILES["insert_dependency"]}
insert_lint_rule ${TARGET_FILES["insert_lint_rule"]}

print_message "$BG_GREEN" "Patch process completed successfully!"