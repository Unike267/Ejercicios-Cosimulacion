#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "Analyze state_decoder.vhd and tb_state_decoder.vhd"
ghdl -a state_decoder.vhd
ghdl -a tb_state_decoder.vhd

echo "Build tb (with main.c)"
ghdl -e -Wl,main.c -o tb_cosim tb_state_decoder

echo "Execute tb"
./tb_cosim
