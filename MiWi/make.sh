#!/usr/bin/env bash

set -ex

cd $(dirname "$0")

cd ..

mkdir -p build

echo "Analyze MIWI"

ghdl -i --std=08 --workdir=build ./MiWi/src/*.vhd
ghdl -i --std=08 --workdir=build ./MiWi/impl/top.vhd
ghdl -m --std=08 --workdir=build top

echo "Synthesis with yosys and ghdl as module"
yosys -m ghdl -p 'ghdl --std=08 --workdir=build top; synth_ice40 -json top_MiWi.json'

echo "Place and route"
nextpnr-ice40 --hx8k --package tq144:4k --pcf ./MiWi/impl/lib.pcf --asc top_MiWi.asc --json top_MiWi.json

echo "Generate bitstream"
icepack top_MiWi.asc top_MiWi.bin

echo "Load bitstream in FPGA (make with sudo)"
which iceprog && iceprog top_MiWi.bin || echo 'Skipping iceprog...'
