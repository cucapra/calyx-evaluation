#!/bin/bash

if [ ! -z "$1" ]; then
    parallelism="$1"
else
    parallelism="-j1"
fi

# make sure results directory exists and run resource estimation
mkdir -p results/systolic/futil
ls benchmarks/systolic-sources/*.systolic | \
    parallel --bar $parallelism \
             "fud e -q {} --to resource-estimate > results/systolic/futil/{/.}.json"

# make results directory for futil-latency and run verilator
mkdir -p results/systolic/futil-latency
ls benchmarks/systolic-sources/*.systolic | \
    parallel --bar $parallelism \
             "fud e -q {} --to vcd_json -s verilog.data '{}.data' | jq '{\"latency\":.TOP.main.clk | add}' > results/systolic/futil-latency/{/.}.json"
