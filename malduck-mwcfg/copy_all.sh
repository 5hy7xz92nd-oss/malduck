#!/bin/bash

# Automated Copy Script for Malduck-MWCFG Combined Repository
# This script copies all necessary files from both source repositories

set -e  # Exit on error

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MALDUCK_SRC="${SCRIPT_DIR}/.."
MWCFG_SRC="/workspaces/mwcfg"

echo "========================================="
echo "Malduck-MWCFG Repository Setup"
echo "========================================="
echo ""

# Function to safely copy files
safe_copy() {
    local src="$1"
    local dest="$2"
    local name="$3"
    
    if [ -e "$src" ]; then
        echo "✓ Copying $name..."
        cp -r "$src" "$dest"
        return 0
    else
        echo "✗ Skipping $name (source not found: $src)"
        return 1
    fi
}

# Check if we're in the right directory
if [ ! -f "${SCRIPT_DIR}/setup.py" ]; then
    echo "Error: This script must be run from the malduck-mwcfg directory"
    exit 1
fi

cd "$SCRIPT_DIR"

echo "Step 1: Copying Malduck source files..."
echo "----------------------------------------"

# Copy main malduck Python files
for file in __init__.py bits.py disasm.py dnpe.py ints.py main.py pe.py py.typed structure.py verify.py yara.py yara.pyi; do
    safe_copy "${MALDUCK_SRC}/malduck/$file" "./malduck/" "malduck/$file"
done

# Copy malduck subdirectories
for dir in compression crypto extractor hash procmem string; do
    if [ -d "${MALDUCK_SRC}/malduck/$dir" ]; then
        echo "✓ Copying malduck/$dir/..."
        rm -rf "./malduck/$dir"
        cp -r "${MALDUCK_SRC}/malduck/$dir" "./malduck/"
    fi
done

echo ""
echo "Step 2: Copying MWCFG files..."
echo "----------------------------------------"

# Copy libmwcfg
if [ -d "${MWCFG_SRC}/libmwcfg" ]; then
    echo "✓ Copying libmwcfg..."
    rm -rf "./libmwcfg"
    mkdir -p "./libmwcfg"
    cp -r "${MWCFG_SRC}/libmwcfg"/* "./libmwcfg/" 2>/dev/null || echo "  (directory was empty or had errors)"
fi

# Copy modules
if [ -d "${MWCFG_SRC}/modules" ]; then
    echo "✓ Copying extraction modules..."
    # Don't overwrite our README.md
    mv "./modules/README.md" "./modules/README.md.bak"
    cp -r "${MWCFG_SRC}/modules"/* "./modules/" 2>/dev/null || echo "  (directory was empty or had errors)"
    mv "./modules/README.md.bak" "./modules/README.md"
fi

echo ""
echo "Step 3: Copying tests..."
echo "----------------------------------------"

if [ -d "${MALDUCK_SRC}/tests" ]; then
    echo "✓ Copying test files..."
    cp -r "${MALDUCK_SRC}/tests"/* "./tests/" 2>/dev/null || echo "  (directory was empty)"
fi

echo ""
echo "Step 4: Copying documentation..."
echo "----------------------------------------"

if [ -d "${MALDUCK_SRC}/docs" ]; then
    echo "✓ Copying documentation files..."
    cp -r "${MALDUCK_SRC}/docs"/* "./docs/" 2>/dev/null || echo "  (directory was empty)"
fi

echo ""
echo "Step 5: Copying Docker configuration..."
echo "----------------------------------------"

if [ -d "${MWCFG_SRC}/docker" ]; then
    echo "✓ Copying Docker files..."
    cp -r "${MWCFG_SRC}/docker"/* "./docker/" 2>/dev/null || echo "  (directory was empty)"
fi

echo ""
echo "Step 6: Copying additional configuration files..."
echo "----------------------------------------"

safe_copy "${MALDUCK_SRC}/MANIFEST.in" "./" "MANIFEST.in"
safe_copy "${MALDUCK_SRC}/readthedocs.yml" "./" "readthedocs.yml"
safe_copy "${MALDUCK_SRC}/setup.cfg" "./" "setup.cfg"

echo ""
echo "========================================="
echo "File Copy Complete!"
echo "========================================="
echo ""
echo "Summary of copied items:"
echo "  - Malduck core library files"
echo "  - Malduck submodules (crypto, compression, etc.)"
echo "  - MWCFG library files"
echo "  - Configuration extraction modules"
echo "  - Test files"
echo "  - Documentation"
echo "  - Docker configuration"
echo ""
echo "Next steps:"
echo "  1. Review the copied files"
echo "  2. Install the package: pip install -e ."
echo "  3. Run tests: make test"
echo "  4. Initialize git: git init && git add . && git commit -m 'Initial commit'"
echo ""
echo "For more information, see COPY_INSTRUCTIONS.md"
echo ""
