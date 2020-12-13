#!/bin/bash

if [ ! -z "$1" ]; then
    parallelism="$1"
else
    parallelism="-j1"
fi

# static timing enabled (7 minutes)
mkdir -p ./results/latency-sensitive/with-static-timing
ls ./benchmarks/polybench/*.fuse | \
    parallel --bar $parallelism \
             "fud e -q {} --to vcd_json -s verilog.data '{}.data' | jq '{\"latency\":.TOP.main.clk | add}' > results/latency-sensitive/with-static-timing/{/.}.json"

# static timing disabled (9 minutes)
mkdir -p ./results/latency-sensitive/no-static-timing
ls ./benchmarks/polybench/*.fuse | \
    parallel --bar $parallelism \
             "fud e -q {} --to vcd_json -s futil.flags '-d static-timing' -s verilog.data '{}.data' | jq '{\"latency\":.TOP.main.clk | add}' > results/latency-sensitive/no-static-timing/{/.}.json"
