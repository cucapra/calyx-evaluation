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
             "fud e -q {} --to resource-estimate -s synth-verilog.remote 1 > results/systolic/futil/{/.}.json"

# make sure results directory exists and run resource estimation
mkdir -p results/systolic/futil-no-static
ls benchmarks/systolic-sources/*.systolic | \
    parallel --bar $parallelism \
             "fud e -q {} --to resource-estimate -s synth-verilog.remote 1 -s futil.flags '-d static-timing' > results/systolic/futil-no-static/{/.}.json"

# make results directory for futil-latency and run verilator
mkdir -p results/systolic/futil-latency
ls benchmarks/systolic-sources/*.systolic | \
    parallel --bar $parallelism \
             "fud e -q {} --to dat -s verilog.data '{}.data' | jq '{\"latency\":.cycles }' > results/systolic/futil-latency/{/.}.json"
