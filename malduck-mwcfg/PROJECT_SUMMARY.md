# Malduck-MWCFG Combined Repository - Setup Summary

## ✅ What Has Been Created

This combined repository integrates **Malduck** (malware analysis library) and **MWCFG** (configuration extraction toolkit) into a unified project.

### Core Files Created

1. **README.md** - Comprehensive documentation covering both tools
2. **setup.py** - Combined package installation script
3. **pyproject.toml** - Modern Python package configuration
4. **requirements.txt** - Merged dependencies from both projects
5. **LICENSE** - Combined licensing information (GPLv3 + BSD-3-Clause)
6. **CONTRIBUTING.md** - Detailed contribution guidelines for both core and modules
7. **QUICKSTART.md** - Quick start guide for new users
8. **Makefile** - Build automation for installation, testing, and Docker deployment
9. **mwcfg** - Command-line tool for configuration extraction
10. **.gitignore** - Comprehensive ignore patterns
11. **COPY_INSTRUCTIONS.md** - Manual copy instructions
12. **copy_all.sh** - Automated copy script

### Directory Structure

```
malduck-mwcfg/
├── README.md              # Main documentation
├── setup.py               # Installation script
├── pyproject.toml         # Package metadata
├── requirements.txt       # Dependencies
├── LICENSE                # License information
├── CONTRIBUTING.md        # Contribution guide
├── QUICKSTART.md          # Quick start guide
├── Makefile               # Build automation
├── mwcfg                  # CLI tool script
├── .gitignore             # Git ignore rules
├── copy_all.sh            # Automated copy script ⚠️ RUN THIS
├── COPY_INSTRUCTIONS.md   # Manual instructions
├── malduck/               # Malduck library (needs content)
│   └── __init__.py
├── libmwcfg/              # MWCFG library (needs content)
│   └── __init__.py
├── modules/               # Extraction modules (needs content)
│   ├── __init__.py
│   └── README.md
├── tests/                 # Test directory (needs content)
├── docs/                  # Documentation (needs content)
└── docker/                # Docker configs (needs content)
```

## 🔄 Next Steps Required

The structure is ready, but you need to copy the actual source code:

### Option 1: Use the Automated Script (Recommended)

```bash
cd /workspaces/malduck/malduck-mwcfg
chmod +x copy_all.sh
./copy_all.sh
```

### Option 2: Manual Copy

See [COPY_INSTRUCTIONS.md](COPY_INSTRUCTIONS.md) for detailed manual copy instructions.

### After Copying Files

1. **Install the package:**
   ```bash
   pip install -e .
   ```

2. **Test the installation:**
   ```bash
   python -c "import malduck; print('Malduck version:', malduck.__version__)"
   mwcfg --modules modules/ --list-modules
   ```

3. **Initialize Git:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Combined Malduck and MWCFG repository"
   ```

4. **Create GitHub repository and push:**
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/malduck-mwcfg.git
   git branch -M main
   git push -u origin main
   ```

## 📦 What This Combined Repository Provides

### From Malduck:
- ✅ Cryptographic operations (AES, Blowfish, Camellia, ChaCha20, Serpent, etc.)
- ✅ Compression algorithms (aPLib, gzip, LZNT1)
- ✅ Memory analysis tools (PE/ELF parsing, memory dumps)
- ✅ Fixed integer types and bitwise operations
- ✅ String operations and hashing algorithms
- ✅ Core extraction framework

### From MWCFG:
- ✅ Command-line configuration extraction tool
- ✅ Web server with REST API
- ✅ Modular extractor framework
- ✅ Multi-threaded processing
- ✅ Docker deployment support
- ✅ Karton framework integration

### New Combined Features:
- ✅ Unified installation process
- ✅ Integrated documentation
- ✅ Combined CLI tools
- ✅ Comprehensive contribution guidelines
- ✅ Automated build and deployment
- ✅ Docker support for web services

## 🔧 Usage Examples

### Extract Configuration
```bash
mwcfg --input malware.bin --modules modules/ --debug --pretty
```

### Use Malduck Library
```python
from malduck import aes, aplib, procmem

# Decrypt AES
decrypted = aes.cbc.decrypt(key, iv, ciphertext)

# Decompress APLib
decompressed = aplib(compressed)

# Analyze memory dump
mem = procmem.from_file('dump.bin')
```

### Start Web Server
```bash
make mwcfg-server-start
```

## 📚 Documentation

- **Malduck API:** https://malduck.readthedocs.io/
- **MWCFG Website:** https://mwcfg.info
- **Contributing:** See [CONTRIBUTING.md](CONTRIBUTING.md)
- **Quick Start:** See [QUICKSTART.md](QUICKSTART.md)

## 🐛 Known Issues / TODOs

- [ ] Source code needs to be copied (run copy_all.sh)
- [ ] Update GitHub URLs in configuration files
- [ ] Test full installation after copying files
- [ ] Verify all dependencies are correctly merged
- [ ] Test Docker build and deployment
- [ ] Add CI/CD configuration (.github/workflows/)

## 📝 Key Configuration Files

### setup.py
- Combined package name: `malduck-mwcfg`
- Version: `1.0.0`
- Includes both malduck and libmwcfg packages
- Entry points for both `malduck` and `mwcfg` commands

### requirements.txt
- Merged dependencies from both projects
- No conflicts detected
- Ready for installation

### Makefile
- Installation targets
- Testing targets
- Docker server management
- Documentation building
- Code formatting and linting

## 🎯 Project Goals

This combined repository aims to:
1. Provide a unified toolkit for malware analysis
2. Simplify installation and deployment
3. Enable seamless integration between analysis and extraction
4. Support both research and operational use cases
5. Maintain compatibility with existing tools (Karton, MWDB)

## 🤝 Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for:
- Code style guidelines
- How to create extraction modules
- Testing requirements
- Pull request process

## 📄 License

- **Malduck components:** GPLv3
- **MWCFG components:** BSD-3-Clause

See [LICENSE](LICENSE) for full details.

## 💬 Support

- GitHub Issues: [Report bugs or request features]
- Documentation: [Malduck Docs](https://malduck.readthedocs.io/)
- Community: CERT Polska, @c3rb3ru5d3d53c

---

**Created:** $(date)  
**Status:** ⚠️ Awaiting source code copy - Run `./copy_all.sh`  
**Next Action:** Execute copy script to populate source directories
