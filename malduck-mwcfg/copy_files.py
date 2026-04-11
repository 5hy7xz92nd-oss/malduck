#!/usr/bin/env python3
import shutil
import os
from pathlib import Path

# Copy malduck files
source_malduck = '/workspaces/malduck'
dest = '/workspaces/malduck/malduck-mwcfg'

# Items to exclude
exclude = {'.git', 'malduck-mwcfg', '__pycache__', '*.pyc', '.gitignore'}

def should_copy(path):
    for ex in exclude:
        if ex in str(path):
            return False
    return True

# Copy malduck content
for item in os.listdir(source_malduck):
    source_path = os.path.join(source_malduck, item)
    if item not in exclude and os.path.exists(source_path):
        dest_path = os.path.join(dest, item)
        try:
            if os.path.isdir(source_path):
                if not os.path.exists(dest_path):
                    shutil.copytree(source_path, dest_path, ignore=shutil.ignore_patterns('.git', '__pycache__', '*.pyc'))
                    print(f"Copied directory: {item}")
            else:
                shutil.copy2(source_path, dest_path)
                print(f"Copied file: {item}")
        except Exception as e:
            print(f"Error copying {item}: {e}")

print("\nCopying mwcfg files...")
source_mwcfg = '/workspaces/mwcfg'

# Copy mwcfg specific files
mwcfg_items = ['mwcfg', 'mwcfg-server', 'libmwcfg', 'modules']
for item in mwcfg_items:
    source_path = os.path.join(source_mwcfg, item)
    if os.path.exists(source_path):
        dest_path = os.path.join(dest, item)
        try:
            if os.path.isdir(source_path):
                if os.path.exists(dest_path):
                    shutil.rmtree(dest_path)
                shutil.copytree(source_path, dest_path, ignore=shutil.ignore_patterns('.git', '__pycache__', '*.pyc'))
                print(f"Copied directory: {item}")
            else:
                shutil.copy2(source_path, dest_path)
                print(f"Copied file: {item}")
        except Exception as e:
            print(f"Error copying {item}: {e}")

print("\nDone!")
