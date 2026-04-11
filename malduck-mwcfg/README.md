# :duck: Malduck + MWCFG - Combined Malware Analysis Toolkit

## [Installation ⚙️](#installation) | [Malduck Docs 📚](https://malduck.readthedocs.io/en/latest/) | [MWCFG Info 🔧](https://mwcfg.info)

---

This repository combines **Malduck** malware analysis library with **MWCFG** configuration extraction tools, providing a comprehensive toolkit for malware analysis and configuration extraction.

## About Malduck

Malduck is your ducky companion in malware analysis journeys. It is mostly based on [Roach](https://github.com/hatching/roach) project, which derives many concepts from [mlib](https://github.com/mak/mlib) 
library created by [Maciej Kotowicz](https://lokalhost.pl). The purpose of fork was to make Roach independent from [Cuckoo Sandbox](https://cuckoosandbox.org/) project, but still supporting its internal `procmem` format.

## About MWCFG

MWCFG is a modular malware configuration extraction utility built on top of Malduck. It provides a command-line tool and web server for extracting configurations from malware samples.

## Features

### Malduck Features
- **Cryptography** (AES, Blowfish, Camellia, ChaCha20, Serpent and many others)
- **Compression algorithms** (aPLib, gzip, LZNT1 (RtlDecompressBuffer))
- **Memory model objects** (work on memory dumps, PE/ELF, raw files and IDA dumps using the same code)
- **Extraction engine** (modular extraction framework for config extraction from files/dumps)
- Fixed integer types (like Uint64) and bitwise utilities
- String operations (chunks, padding, packing/unpacking etc)
- Hashing algorithms (CRC32, MD5, SHA1, SHA256)

### MWCFG Features
- **Modular configuration extractors** for various malware families
- **Command-line tool** for batch extraction
- **Web server** with REST API for extraction services
- **Multi-threaded processing** for performance
- **Docker support** for easy deployment
- **Karton framework integration** for automated workflows

## Installation

### Basic Installation

```bash
sudo apt update
sudo apt install -y python3-virtualenv python3 git-lfs gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update
sudo apt install mono-devel
git clone --recursive https://github.com/YOUR_USERNAME/malduck-mwcfg.git
cd malduck-mwcfg/
virtualenv -p python3 venv
source venv/bin/activate
pip install -v .
```

### Installation with PyPi (Separate Packages)

```bash
pip install malduck
pip install mwcfg
```

## Usage

### Malduck Usage Examples

#### AES Encryption/Decryption

```python
from malduck import aes

key = b'A'*16
iv = b'B'*16
plaintext = b'data'*16
ciphertext = aes.cbc.encrypt(key, iv, plaintext)
decrypted = aes.cbc.decrypt(key, iv, ciphertext)
```

#### Serpent Encryption

```python
from malduck import serpent

key = b'a'*16
iv = b'b'*16
plaintext = b'data'*16
ciphertext = serpent.cbc.encrypt(key, plaintext, iv)
```

#### APLib Decompression

```python
from malduck import aplib

# Decompress APLib compressed data
decompressed = aplib(compressed_data)
```

#### Process Memory Analysis

```python
from malduck import procmem

# Load memory dump
p = procmem.from_file('malware.dmp')

# Search for patterns
for addr in p.findv(b'MZ'):
    print(f"Found MZ header at {hex(addr)}")

# Extract PE files
for pe in p.pefile():
    print(f"Found PE at {hex(pe.imgbase)}")
```

### MWCFG Usage

#### Command-Line Tool

```bash
# Extract configuration from a single file
mwcfg --input sample.bin --modules modules/ --debug

# Extract from multiple files with threading
mwcfg --input samples/ --modules modules/ --threads 4 --recursive --pretty

# List available modules
mwcfg --modules modules/ --list-modules
```

#### MWCFG Server

##### Using Docker

```bash
# Build the server
make mwcfg-server

# Start the server
make mwcfg-server-start

# Check status
make mwcfg-server-status

# View logs
make mwcfg-server-logs

# Stop the server
make mwcfg-server-stop
```

##### Using Python Directly

```bash
mwcfg-server --host 0.0.0.0 --port 8080 --modules modules/
```

##### API Usage

```bash
# Upload sample via curl
curl --silent --insecure -X POST --upload-file sample.bin https://127.0.0.1

# Or navigate to https://127.0.0.1 for web interface
```

### Creating Custom Extractors

Create a new extractor module in `modules/yourmalware/`:

**modules/yourmalware/__init__.py:**
```python
from .yourmalware import YourMalware
__all__ = ['YourMalware']
```

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
    
    @Extractor.extractor
    def extract_config(self, p, addr):
        # Extract configuration data
        config_data = p.readv(addr, 0x100)
        
        return {
            'family': 'yourmalware',
            'c2': self.extract_c2(config_data),
            'key': self.extract_key(config_data)
        }
    
    def extract_c2(self, data):
        # Your extraction logic
        return "example.com"
    
    def extract_key(self, data):
        # Your extraction logic
        return "secret_key"
```

**modules/yourmalware/yourmalware.yar:**
```yara
rule yourmalware {
    meta:
        author = "Your Name"
        module = "yourmalware"
    strings:
        $string1 = "unique_string" ascii
        $string2 = { 6A 40 68 00 30 00 00 }
    condition:
        all of them
}
```

## Documentation

- **Malduck Documentation:** [https://malduck.readthedocs.io/en/latest/](https://malduck.readthedocs.io/en/latest/)
- **MWCFG Website:** [https://mwcfg.info](https://mwcfg.info)
- **Contributing Guide:** [CONTRIBUTING.md](CONTRIBUTING.md)

## Additional Resources

- [MWDB Core](https://github.com/CERT-Polska/mwdb-core)
- [MWDB Documentation](https://mwdb.readthedocs.io/en/latest/)
- [Karton Framework](https://github.com/CERT-Polska/karton)
- [Karton Config Extractor](https://github.com/CERT-Polska/karton-config-extractor)
- [MWCFG Modules](https://github.com/c3rb3ru5d3d53c/mwcfg-modules)

## Karton Framework Integration

```bash
sudo apt install -y python3-virtualenv python3 git-lfs
git clone --recursive https://github.com/YOUR_USERNAME/malduck-mwcfg.git
cd malduck-mwcfg/
virtualenv venv/
source venv/bin/activate
./setup.py install
pip install karton-config-extractor
karton-config-extractor --config-file karton.ini --modules modules/
```

## Command-Line Reference

### malduck

```text
usage: malduck [-h] [--version] {test} ...

Malduck command-line utilities

positional arguments:
  {test}      Available commands

optional arguments:
  -h, --help  show this help message and exit
  --version   show program's version number and exit
```

### mwcfg

```text
usage: mwcfg v1.0.1 [-h] [--version] [-i INPUT] -m MODULES [--list-modules] 
                    [-d] [-p] [-t THREADS] [-r] [-l LOG]

A Modular Malware Configuration Extraction Utility for MalDuck

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i INPUT, --input INPUT
                        Input File or Directory
  -m MODULES, --modules MODULES
                        Modules
  --list-modules        List available extraction modules
  -d, --debug           Debug logging
  -p, --pretty          Pretty print JSON configs
  -t THREADS, --threads THREADS
                        Number of threads
  -r, --recursive       Recursive directory processing
  -l LOG, --log LOG     Log to file
```

### mwcfg-server

```text
usage: mwcfg-server v1.0.0 [-h] [--version] [--host HOST] [-p PORT] 
                            -m MODULES [-u UPLOADS] [-d] [-l LOG]

A Modular Malware Configuration Extraction Server using MalDuck

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --host HOST           Host address (default: 127.0.0.1)
  -p PORT, --port PORT  Port number (default: 8080)
  -m MODULES, --modules MODULES
                        Path to modules directory
  -u UPLOADS, --uploads UPLOADS
                        Directory to save uploaded samples
  -d, --debug           Enable debug mode
  -l LOG, --log LOG     Log file path
```

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### For Malduck Core Features
- Follow the existing code style
- Add tests for new features
- Update documentation

### For MWCFG Modules
- Create a new module directory
- Include YARA rules
- Provide extraction logic
- Add README with sample info

## License

- **Malduck:** GPLv3 - Copyright (c) CERT Polska
- **MWCFG:** BSD 3-Clause - Copyright (c) 2020, CERT Polska

See [LICENSE](LICENSE) files for details.

## Credits

### Malduck
- **Author:** CERT Polska
- **Email:** info@cert.pl
- **Website:** [https://www.cert.pl/](https://www.cert.pl/)

### MWCFG
- **Author:** c3rb3ru5d3d53c
- **Twitter:** [@c3rb3ru5d3d53c](https://twitter.com/c3rb3ru5d3d53c)
- **GitHub:** [c3rb3ru5d3d53c](https://github.com/c3rb3ru5d3d53c)

## Support

If you like this project and wish to support the fight against malware:

Buy the maintainer a tea ☕ by sending Bitcoin to: `16oXesi7uv3jdPZxxwarHSD2f3cNMpaih9`

## Disclaimer

This tool is for educational and research purposes only. Use responsibly and only on malware samples you have permission to analyze.

---

**Co-financed by the Connecting Europe Facility of the European Union**

![Co-financed by the Connecting Europe Facility by of the European Union](https://www.cert.pl/uploads/2019/02/en_horizontal_cef_logo-e1550495232540.png)
