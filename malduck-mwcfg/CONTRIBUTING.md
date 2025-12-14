# Contributing to Malduck-MWCFG

Thank you for your interest in contributing! This project combines two powerful tools:
- **Malduck** - Core malware analysis library
- **MWCFG** - Modular configuration extraction framework

## Types of Contributions

### 1. Malduck Core Improvements
- New cryptographic algorithms
- Compression methods
- Memory analysis features
- Bug fixes and optimizations

### 2. MWCFG Extraction Modules
- New malware family extractors
- YARA rules improvements
- Extraction logic enhancements

## Creating a Configuration Extractor Module

### Step 1: Set Up Development Environment

```bash
git clone --recursive https://github.com/YOUR_USERNAME/malduck-mwcfg.git
cd malduck-mwcfg/
virtualenv venv/
source venv/bin/activate
pip install -e .
```

### Step 2: Create Module Directory Structure

```text
modules/
├── yourmalware/
│   ├── __init__.py       # Module init file
│   ├── yourmalware.py    # Extractor code
│   ├── yourmalware.yar   # YARA signatures
│   └── README.md         # Module documentation
```

### Step 3: Write YARA Signatures

**modules/yourmalware/yourmalware.yar:**
```yara
rule yourmalware {
    meta:
        author = "Your Name"
        module = "yourmalware"
        description = "Detects YourMalware family"
    strings:
        $unique_str1 = "Coded by BadGuy" ascii
        $unique_str2 = "YourMalware v" ascii
        $config_marker = { 43 4F 4E 46 49 47 [4-8] }
        $c2_pattern = { 68 74 74 70 3A 2F 2F }  // http://
    condition:
        uint16(0) == 0x5A4D and  // MZ header
        2 of ($unique_*) or $config_marker
}
```

### Step 4: Write Extractor Code

**modules/yourmalware/yourmalware.py:**
```python
import logging
from malduck.extractor import Extractor

log = logging.getLogger(__name__)

__author__  = "Your Name"
__version__ = "1.0.0"

class YourMalware(Extractor):
    family = "yourmalware"
    yara_rules = "yourmalware",
    
    @Extractor.extractor("unique_str1")
    def extract_version(self, p, addr):
        """Extract malware version from unique string location."""
        # Read data around the matched address
        version_data = p.readv(addr + 16, 10)
        log.debug('[+] Found version string @ %X' % addr)
        return {'version': version_data.decode('utf-8', errors='ignore')}
    
    @Extractor.extractor("config_marker")
    def extract_config(self, p, addr):
        """Extract configuration from config marker location."""
        # Read configuration structure
        config_size = p.uint32v(addr + 6)
        config_data = p.readv(addr + 10, config_size)
        
        # Decrypt if necessary
        if self.is_encrypted(config_data):
            config_data = self.decrypt_config(config_data)
        
        # Parse configuration
        config = self.parse_config(config_data)
        
        log.debug('[+] Extracted config @ %X' % addr)
        return config
    
    @Extractor.extractor("c2_pattern")
    def extract_c2(self, p, addr):
        """Extract C2 URLs from http:// pattern matches."""
        # Read null-terminated string
        c2_url = p.asciiz(addr)
        log.debug('[+] Found C2 URL @ %X: %s' % (addr, c2_url))
        return {'c2': [c2_url]}
    
    def is_encrypted(self, data):
        """Check if configuration data is encrypted."""
        # Implement your logic
        return data[0] == 0xFF
    
    def decrypt_config(self, data):
        """Decrypt configuration data."""
        # Example: XOR decryption
        key = b'SecretKey'
        from malduck import xor
        return xor(key, data)
    
    def parse_config(self, data):
        """Parse decrypted configuration data."""
        # Example parsing
        config = {
            'family': 'yourmalware',
            'c2': [],
            'encryption_key': '',
            'mutex': ''
        }
        
        # Parse based on your malware's structure
        # This is just an example
        offset = 0
        num_c2s = data[offset]
        offset += 1
        
        for i in range(num_c2s):
            c2_len = data[offset]
            offset += 1
            c2_url = data[offset:offset + c2_len].decode('utf-8', errors='ignore')
            config['c2'].append(c2_url)
            offset += c2_len
        
        return config
```

**modules/yourmalware/__init__.py:**
```python
from .yourmalware import YourMalware
__all__ = ['YourMalware']
```

### Step 5: Test Your Extractor

```bash
# Test with a single sample
mwcfg --input tests/yourmalware/sample.bin --modules modules/ --debug --pretty

# Test with multiple samples
mwcfg --input tests/yourmalware/ --modules modules/ --threads 4 --recursive --pretty

# List modules to verify yours is loaded
mwcfg --modules modules/ --list-modules
```

### Step 6: Document Your Module

**modules/yourmalware/README.md:**
```markdown
# YourMalware Configuration Extractor

## Description
Brief description of the malware family and what this extractor does.

## Supported Variants
- YourMalware v1.x
- YourMalware v2.x

## Extracted Configuration Fields
- `family`: Malware family name
- `version`: Malware version
- `c2`: List of C2 server URLs
- `encryption_key`: Encryption key used by malware
- `mutex`: Mutex name

## Sample Hashes
Provide some sample hashes for testing:
- `abc123...` (YourMalware v1.0)
- `def456...` (YourMalware v2.0)

## References
- [Malware analysis blog post](https://example.com/analysis)
- [YARA signature source](https://github.com/example/yara-rules)

## Author
Your Name (@yourusername)

## Version
1.0.0
```

## Code Style Guidelines

### Python Code
- Follow PEP 8 style guide
- Use meaningful variable names
- Add docstrings to all functions and classes
- Include type hints where appropriate
- Add logging statements for debugging

### YARA Rules
- Use descriptive rule names
- Include metadata (author, module, description)
- Add comments explaining string patterns
- Test for false positives

### Testing
- Test with multiple samples of the malware family
- Test with benign files to avoid false positives
- Verify all configuration fields are extracted correctly
- Test error handling with corrupted/modified samples

## Submission Process

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/yourmalware-extractor
   ```
3. **Make your changes**
4. **Test thoroughly**
5. **Commit with descriptive messages**
   ```bash
   git commit -m "Add YourMalware configuration extractor"
   ```
6. **Push to your fork**
   ```bash
   git push origin feature/yourmalware-extractor
   ```
7. **Create a Pull Request**

## Pull Request Guidelines

- Provide a clear description of the changes
- Reference any related issues
- Include sample hashes (if applicable)
- Ensure all tests pass
- Update documentation if needed

## Advanced Extractor Features

### Handling Multiple Configuration Formats

```python
class YourMalware(Extractor):
    family = "yourmalware"
    yara_rules = "yourmalware",
    
    @Extractor.extractor("config_v1")
    def extract_config_v1(self, p, addr):
        """Extract v1.x configuration format."""
        return self.parse_config_v1(p, addr)
    
    @Extractor.extractor("config_v2")
    def extract_config_v2(self, p, addr):
        """Extract v2.x configuration format."""
        return self.parse_config_v2(p, addr)
```

### Using Malduck Crypto Features

```python
from malduck import aes, rc4, xor

def decrypt_config(self, data, key):
    # AES decryption
    iv = data[:16]
    encrypted = data[16:]
    decrypted = aes.cbc.decrypt(key, iv, encrypted)
    
    # RC4 decryption
    # decrypted = rc4(key, encrypted)
    
    # XOR decryption
    # decrypted = xor(key, encrypted)
    
    return decrypted
```

### Working with PE Structures

```python
@Extractor.extractor
def extract_from_pe(self, p, addr):
    # Access PE file information
    pe = p.pe
    if not pe:
        return None
    
    # Get resources
    for resource in pe.resources():
        if resource.name == "CONFIG":
            config_data = resource.data
            return self.parse_config(config_data)
```

## Debugging Tips

1. **Use debug logging extensively**
   ```python
   log.debug('[+] Found marker @ %X' % addr)
   log.debug('[+] Config size: %d' % size)
   log.debug('[+] Decrypted data: %s' % data.hex())
   ```

2. **Test with --debug flag**
   ```bash
   mwcfg --input sample.bin --modules modules/ --debug
   ```

3. **Inspect memory dumps**
   ```python
   # Dump hex data for inspection
   hex_dump = p.readv(addr, 256).hex()
   log.debug(hex_dump)
   ```

## Community Resources

- **Malduck Documentation:** https://malduck.readthedocs.io/
- **MWDB Core:** https://github.com/CERT-Polska/mwdb-core
- **Karton Framework:** https://github.com/CERT-Polska/karton
- **MWCFG Modules Repository:** https://github.com/c3rb3ru5d3d53c/mwcfg-modules

## Getting Help

- Open an issue on GitHub
- Check existing extractors for examples
- Review Malduck documentation
- Join the community discussions

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (GPLv3 for Malduck core, BSD-3-Clause for MWCFG modules).

## Recognition

Contributors will be credited in:
- Module author metadata
- Project contributors list
- Release notes

Thank you for contributing to the fight against malware! 🦆🔧
