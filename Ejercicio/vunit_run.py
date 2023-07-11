#!/usr/bin/env python3

from pathlib import Path
from vunit import VUnit

vu = VUnit.from_argv()
vu.add_vhdl_builtins()

lib = vu.add_library("lib").add_source_files(Path(__file__).resolve().parent / "*.vhd")

vu.main()
