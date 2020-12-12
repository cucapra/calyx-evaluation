#!/bin/bash

# make sure results directory exists
mkdir -p results/systolic/futil

# run resource estimation on all systolic arrays
ls benchmarks/systolic-sources/*.systolic | \
    parallel --bar -j4 \
             "fud e -q --from systolic --to resource-estimate -s systolic.flags '\$(cat {})' > results/systolic/futil/{/.}.json"

# make results directory for futil-latency
mkdir -p results/systolic/futil-latency

# run verilator simulation on systolic arrays
ls benchmarks/systolic-sources/*.futil | \
    parallel --bar -j4 \
             "fud e -q --from systolic --to vcd_json -s systolic.flags '\$(cat {})' -s verilog.data '{}.data' | jq '{\"latency\":.TOP.main.clk | add}' > results/systolic/futil-latency/{/.}.json"
