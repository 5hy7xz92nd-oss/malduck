# Malware Configuration Extraction Modules

This directory contains modular extractors for various malware families.

## Directory Structure

Each malware family should have its own subdirectory:

```
modules/
├── __init__.py
├── citadel/
│   ├── __init__.py
│   ├── citadel.py
│   ├── citadel.yar
│   └── README.md
├── emotet/
│   ├── __init__.py
│   ├── emotet.py
│   ├── emotet.yar
│   └── README.md
└── ... (more families)
```

## Adding New Modules

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed instructions on creating new extraction modules.

## Available Modules

To list all available modules:
```bash
mwcfg --modules ./modules --list-modules
```

## Module Sources

For a collection of ready-to-use modules, see:
- [MWCFG Modules Repository](https://github.com/c3rb3ru5d3d53c/mwcfg-modules)

## Testing Modules

```bash
# Test a specific module
mwcfg --input sample.bin --modules ./modules --debug --pretty

# Test with multiple samples
mwcfg --input samples/ --modules ./modules --threads 4 --recursive
```
