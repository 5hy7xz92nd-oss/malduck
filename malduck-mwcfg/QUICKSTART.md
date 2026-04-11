# Quick Start Guide

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/malduck-mwcfg.git
cd malduck-mwcfg/
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -e .
```

## Quick Examples

### Extract configuration from a malware sample

```bash
# Basic extraction
mwcfg --input sample.bin --modules modules/ --pretty

# With debug output
mwcfg --input sample.bin --modules modules/ --debug --pretty

# Batch processing
mwcfg --input samples/ --modules modules/ --threads 4 --recursive --pretty
```

### Use Malduck for analysis

```python
from malduck import procmem, aes, aplib

# Load memory dump
mem = procmem.from_file('dump.bin')

# Search for patterns
for addr in mem.findv(b'malware_string'):
    print(f"Found at {hex(addr)}")

# Decrypt AES
key = b'secretkey1234567'
iv = b'initvector123456'
decrypted = aes.cbc.decrypt(key, iv, encrypted_data)

# Decompress APLib
decompressed = aplib(compressed_data)
```

### Start the web server

```bash
# Using Python
mwcfg-server --host 0.0.0.0 --port 8080 --modules modules/

# Using Docker
make mwcfg-server
make mwcfg-server-start
```

## Next Steps

- Read the [full README](README.md)
- Check [CONTRIBUTING.md](CONTRIBUTING.md) for creating modules
- Browse [Malduck documentation](https://malduck.readthedocs.io/)
- Explore example modules in `modules/`

## Common Issues

### Missing dependencies
```bash
pip install -r requirements.txt
```

### YARA not installed
```bash
# Ubuntu/Debian
sudo apt install yara python3-yara

# Or via pip
pip install yara-python
```

### Module not found
```bash
# List available modules
mwcfg --modules modules/ --list-modules

# Verify module structure
ls -la modules/your_module/
```

## Getting Help

- Check existing [issues](https://github.com/YOUR_USERNAME/malduck-mwcfg/issues)
- Read the documentation
- Review example modules
