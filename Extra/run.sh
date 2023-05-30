set -e

cd $(dirname "$0")

echo "Analyze state_decoder.vhd and top.vhd"

ghdl -a state_decoder.vhd

ghdl -a top.vhd

echo "Synthesis with yosys and ghdl as module"

yosys -m ghdl -p 'ghdl top; synth_ice40 -json top.json'

echo "Place and route"

nextpnr-ice40 --hx8k --package tq144:4k --pcf lib.pcf --asc top.asc --json top.json

echo "Generate bitstream"

icepack top.asc top.bin

echo "Load bitstream in FPGA (make with sudo)"

iceprog top.bin

