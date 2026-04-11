#!/usr/bin/env python

try:
    from setuptools import setup, find_packages
except ImportError:
    from distutils.core import setup, find_packages

import os

__version__ = '1.0.0'  # Combined version

this_directory = os.path.abspath(os.path.dirname(__file__))
with open(os.path.join(this_directory, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

setup(
    name='malduck-mwcfg',
    version=__version__,
    maintainer='CERT Polska + c3rb3ru5d3d53c',
    description='Combined Malduck malware analysis library with MWCFG configuration extraction tools',
    long_description=long_description,
    long_description_content_type='text/markdown',
    author='CERT Polska, c3rb3ru5d3d53c',
    author_email='info@cert.pl',
    packages=find_packages(),
    package_data={
        "malduck": ["py.typed"],
        "libmwcfg": ["dnlib/*.dll"]
    },
    entry_points={
        "console_scripts": [
            "malduck = malduck.main:main",
            "mwcfg = mwcfg:main",
            "mwcfg-server = mwcfg_server:main",
        ],
    },
    scripts=['mwcfg', 'mwcfg-server'],
    license='GPLv3 + BSD-3-Clause',
    include_package_data=True,
    install_requires=open('requirements.txt', 'r').read().splitlines(),
    url='https://github.com/YOUR_USERNAME/malduck-mwcfg',
    classifiers=[
        "Programming Language :: Python :: 3",
        "Operating System :: POSIX :: Linux",
        "Operating System :: OS Independent",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
        "License :: OSI Approved :: BSD License",
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "Intended Audience :: Information Technology",
        "Intended Audience :: Science/Research",
        "Topic :: Security",
        "Topic :: Software Development :: Libraries :: Python Modules",
    ],
    python_requires='>=3.8',
    keywords='malware analysis configuration extraction malduck mwcfg forensics',
)
