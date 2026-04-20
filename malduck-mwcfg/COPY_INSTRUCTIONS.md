# Copy Instructions

## How to Complete the Repository Setup

This repository structure has been created with all necessary configuration files, 
documentation, and setup scripts. To complete the setup, you need to copy the actual 
source code from both original repositories.

### Step 1: Copy Malduck Source Files

Copy all Python files from the original Malduck repository:

```bash
# From /workspaces/malduck/ copy to /workspaces/malduck/malduck-mwcfg/malduck/
cp -r /workspaces/malduck/malduck/* /workspaces/malduck/malduck-mwcfg/malduck/
```

This includes:
- `__init__.py`
- `bits.py`
- `disasm.py`
- `dnpe.py`
- `ints.py`
- `main.py`
- `pe.py`
- `py.typed`
- `structure.py`
- `verify.py`
- `yara.py`
- `yara.pyi`
- All subdirectories: `compression/`, `crypto/`, `extractor/`, `hash/`, `procmem/`, `string/`

### Step 2: Copy MWCFG Library Files

```bash
# Copy libmwcfg if it exists in the mwcfg repository
cp -r /workspaces/mwcfg/libmwcfg/* /workspaces/malduck/malduck-mwcfg/libmwcfg/
```

### Step 3: Copy Extraction Modules

```bash
# Copy modules from mwcfg repository or mwcfg-modules repository
cp -r /workspaces/mwcfg/modules/* /workspaces/malduck/malduck-mwcfg/modules/
```

### Step 4: Copy Tests

```bash
# Copy test files
cp -r /workspaces/malduck/tests/* /workspaces/malduck/malduck-mwcfg/tests/
```

### Step 5: Copy Documentation

```bash
# Copy documentation files
cp -r /workspaces/malduck/docs/* /workspaces/malduck/malduck-mwcfg/docs/
```

### Step 6: Copy Docker Files (if using mwcfg-server)

```bash
# Copy Docker configuration if it exists
cp -r /workspaces/mwcfg/docker/* /workspaces/malduck/malduck-mwcfg/docker/
```

### Step 7: Copy Additional Files

```bash
# Copy MANIFEST.in if needed
cp /workspaces/malduck/MANIFEST.in /workspaces/malduck/malduck-mwcfg/

# Copy readthedocs configuration
cp /workspaces/malduck/readthedocs.yml /workspaces/malduck/malduck-mwcfg/

# Copy setup.cfg if it exists
cp /workspaces/malduck/setup.cfg /workspaces/malduck/malduck-mwcfg/
```

### Step 8: Initialize Git Repository

```bash
cd /workspaces/malduck/malduck-mwcfg/
git init
git add .
git commit -m "Initial commit: Combined Malduck and MWCFG repository"
```

### Step 9: Create GitHub Repository

1. Go to GitHub and create a new repository named `malduck-mwcfg`
2. Push your local repository:

```bash
git remote add origin https://github.com/YOUR_USERNAME/malduck-mwcfg.git
git branch -M main
git push -u origin main
```

### Step 10: Test Installation

```bash
# Install in development mode
pip install -e .

# Test malduck
python -c "import malduck; print(malduck.__version__)"

# Test mwcfg (requires modules)
mwcfg --modules modules/ --list-modules
```

## What's Already Configured

✅ `README.md` - Comprehensive documentation  
✅ `setup.py` - Package installation configuration  
✅ `pyproject.toml` - Modern Python package metadata  
✅ `requirements.txt` - Consolidated dependencies  
✅ `CONTRIBUTING.md` - Contribution guidelines  
✅ `LICENSE` - Combined license information  
✅ `Makefile` - Build and deployment automation  
✅ `mwcfg` - Command-line tool script  
✅ `.gitignore` - Git ignore rules  
✅ `QUICKSTART.md` - Quick start guide  

## What Still Needs to Be Copied

❌ Malduck source code (all `.py` files)  
❌ MWCFG library files  
❌ Extraction modules  
❌ Test files  
❌ Documentation source files  
❌ Docker configuration files  

## Using Terminal Commands to Copy

If you have terminal access, you can run this script:

```bash
#!/bin/bash
cd /workspaces/malduck/malduck-mwcfg/

# Copy Malduck
echo "Copying Malduck source files..."
cp -r ../malduck/* ./malduck/ 2>/dev/null || echo "Malduck files copied"

# Copy from mwcfg
echo "Copying MWCFG files..."
cp -r /workspaces/mwcfg/libmwcfg/* ./libmwcfg/ 2>/dev/null || echo "LibMWCFG copied"
cp -r /workspaces/mwcfg/modules/* ./modules/ 2>/dev/null || echo "Modules copied"
cp -r /workspaces/mwcfg/docker/* ./docker/ 2>/dev/null || echo "Docker files copied"

# Copy tests
echo "Copying tests..."
cp -r ../tests/* ./tests/ 2>/dev/null || echo "Tests copied"

# Copy docs
echo "Copying documentation..."
cp -r ../docs/* ./docs/ 2>/dev/null || echo "Docs copied"

# Copy additional config files
cp ../MANIFEST.in ./ 2>/dev/null || echo "MANIFEST.in copied"
cp ../readthedocs.yml ./ 2>/dev/null || echo "readthedocs.yml copied"
cp ../setup.cfg ./ 2>/dev/null || echo "setup.cfg copied"

echo "Copy complete! Please review the files and test installation."
```

Save this as `copy_all.sh`, make it executable with `chmod +x copy_all.sh`, and run it with `./copy_all.sh`.
